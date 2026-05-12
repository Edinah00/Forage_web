package edinah.springMVC.forage.Controller;

import edinah.springMVC.forage.Model.*;
import edinah.springMVC.forage.Repository.*;
import edinah.springMVC.forage.Service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/devis")
public class DevisController {

    @Autowired private DevisService          devisService;
    @Autowired private DemandeService        demandeService;
    @Autowired private ClientRepository      clientRepo;
    @Autowired private StatusDevisRepository statusDevisRepo;

    // ── Liste des devis ───────────────────────────────────────────────────────
    @GetMapping
    public String listeDevis(Model model) {
        List<Devis>  devisList = devisService.listerDevis();
        model.addAttribute("devisList", devisList);
        model.addAttribute("demandeService", demandeService);
        model.addAttribute("clientRepo", clientRepo);
        model.addAttribute("devisService", devisService);
        model.addAttribute("statusDevis", statusDevisRepo.findAll());
        // Enrichir avec nom client + dernier statut
        model.addAttribute("demandes", demandeService.listerDemandes());
        model.addAttribute("clients",  clientRepo.findAll());
        return "liste_devis";
    }

    // ── Formulaire création ───────────────────────────────────────────────────
    @GetMapping("/nouveau")
    public String formulaireNouveauDevis(Model model, RedirectAttributes ra) {
        // Seules les demandes ACCEPTÉES (status 3)
        List<Demande> acceptees = demandeService.listerDemandes().stream()
            .filter(d -> devisService.demandeEstAcceptee(d.getId_demande()))
            .toList();

        if (acceptees.isEmpty()) {
            ra.addFlashAttribute("erreur", "Aucune demande acceptée. Acceptez d'abord une demande avant de créer un devis.");
            return "redirect:/devis";
        }
        model.addAttribute("devis",    new Devis());
        model.addAttribute("demandes", acceptees);
        model.addAttribute("clients",  clientRepo.findAll());
        return "form_devis";
    }

    // ── Enregistrer un nouveau devis ──────────────────────────────────────────
    @PostMapping("/enregistrer")
    public String enregistrerDevis(
            @ModelAttribute("devis") Devis devis,
            @RequestParam("libelles")       List<String>     libelles,
            @RequestParam("unites")         List<String>     unites,
            @RequestParam("quantites")      List<java.math.BigDecimal> quantites,
            @RequestParam("prix_unitaires") List<java.math.BigDecimal> prixUnitaires,
            @RequestParam("descriptions")   List<String>     descriptions,
            RedirectAttributes ra) {

        List<DetailDevis> details = new ArrayList<>();
        for (int i = 0; i < libelles.size(); i++) {
            if (libelles.get(i) == null || libelles.get(i).isBlank()) continue;
            DetailDevis d = new DetailDevis();
            d.setLibelle(libelles.get(i));
            d.setUnite(unites.get(i));
            d.setQuantite(quantites.get(i));
            d.setPrix_unitaire(prixUnitaires.get(i));
            d.setDescription(descriptions.get(i));
            details.add(d);
        }
        int id = devisService.creerDevis(devis, details);
        ra.addFlashAttribute("message", "Devis #" + id + " créé avec succès !");
        return "redirect:/devis";
    }

    // ── Détail d'un devis ─────────────────────────────────────────────────────
    @GetMapping("/{id}")
    public String detailDevis(@PathVariable int id, Model model) {
        Devis devis = devisService.getDevis(id);
        if (devis == null) return "redirect:/devis";

        model.addAttribute("devis",     devis);
        model.addAttribute("details",   devisService.getDetails(id));
        model.addAttribute("total",     devisService.getTotalDevis(id));
        model.addAttribute("demande",   demandeService.getDemande(devis.getId_demande()));
        model.addAttribute("clients",   clientRepo.findAll());
        model.addAttribute("historique",devisService.getHistoriqueStatuts(id));
        model.addAttribute("statusDevis", statusDevisRepo.findAll());
        return "detail_devis_complet";
    }

    // ── Formulaire modification ───────────────────────────────────────────────
    @GetMapping("/modifier/{id}")
    public String formulaireModification(@PathVariable int id, Model model) {
        Devis devis = devisService.getDevis(id);
        List<Demande> acceptees = demandeService.listerDemandes().stream()
            .filter(d -> devisService.demandeEstAcceptee(d.getId_demande()))
            .toList();
        model.addAttribute("devis",    devis);
        model.addAttribute("details",  devisService.getDetails(id));
        model.addAttribute("demandes", acceptees);
        model.addAttribute("clients",  clientRepo.findAll());
        return "edit_devis";
    }

    // ── Enregistrer modification ──────────────────────────────────────────────
    @PostMapping("/modifier")
    public String modifierDevis(
            @ModelAttribute("devis") Devis devis,
            @RequestParam("libelles")       List<String>     libelles,
            @RequestParam("unites")         List<String>     unites,
            @RequestParam("quantites")      List<java.math.BigDecimal> quantites,
            @RequestParam("prix_unitaires") List<java.math.BigDecimal> prixUnitaires,
            @RequestParam("descriptions")   List<String>     descriptions,
            RedirectAttributes ra) {

        List<DetailDevis> details = new ArrayList<>();
        for (int i = 0; i < libelles.size(); i++) {
            if (libelles.get(i) == null || libelles.get(i).isBlank()) continue;
            DetailDevis d = new DetailDevis();
            d.setLibelle(libelles.get(i));
            d.setUnite(unites.get(i));
            d.setQuantite(quantites.get(i));
            d.setPrix_unitaire(prixUnitaires.get(i));
            d.setDescription(descriptions.get(i));
            details.add(d);
        }
        devisService.modifierDevis(devis, details);
        ra.addFlashAttribute("message", "Devis modifié avec succès !");
        return "redirect:/devis/" + devis.getId_devis();
    }

    // ── Supprimer un devis ────────────────────────────────────────────────────
    @GetMapping("/supprimer/{id}")
    public String supprimerDevis(@PathVariable int id, RedirectAttributes ra) {
        devisService.supprimerDevis(id);
        ra.addFlashAttribute("message", "Devis supprimé.");
        return "redirect:/devis";
    }

    // ── Changer statut d'un devis ─────────────────────────────────────────────
    @GetMapping("/{id}/statut/{s}")
    public String changerStatut(@PathVariable int id, @PathVariable int s, RedirectAttributes ra) {
        devisService.changerStatut(id, s);
        ra.addFlashAttribute("message", "Statut mis à jour.");
        return "redirect:/devis/" + id;
    }

    // ── Supprimer un détail ───────────────────────────────────────────────────
    @GetMapping("/detail/supprimer/{idDetail}/devis/{idDevis}")
    public String supprimerDetail(@PathVariable int idDetail, @PathVariable int idDevis) {
        devisService.supprimerDetail(idDetail);
        return "redirect:/devis/" + idDevis;
    }
}
