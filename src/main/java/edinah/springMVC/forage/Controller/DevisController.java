package edinah.springMVC.forage.Controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edinah.springMVC.forage.Model.Demande;
import edinah.springMVC.forage.Model.DetailDevis;
import edinah.springMVC.forage.Model.Devis;
import edinah.springMVC.forage.Model.TypeDevis;
import edinah.springMVC.forage.Service.DemandeService;
import edinah.springMVC.forage.Service.DetailDevisService;
import edinah.springMVC.forage.Service.DevisService;

@Controller
@RequestMapping("/devis")
public class DevisController {

    @Autowired
    private DevisService devisService;

    @Autowired
    private DemandeService demandeService;

    @Autowired
    private DetailDevisService detailDevisService;

    @GetMapping
    public String index() {
        return "redirect:/devis/nouveau";
    }

    @GetMapping("/nouveau")
    public String nouveau(Model model) {
        model.addAttribute("devis", new Devis());
        model.addAttribute("typesDevis", devisService.findAllTypeDevis());
        return "devis";
    }

    @GetMapping("/liste")
    public String liste(Model model) {
        model.addAttribute("devisList", devisService.findAll());
        return "liste_devis";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable("id") int id, Model model) {
        Devis devis = devisService.findById(id);
        model.addAttribute("devis", devis);
        model.addAttribute("detailsDevis", detailDevisService.findByIdDevis(id));
        return "detail_devis";
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        devisService.removeDevis(id);
        redirectAttributes.addFlashAttribute("message", "Devis supprimé.");
        return "redirect:/devis/liste";
    }

    @GetMapping("/detail/supprimer/{id}")
    public String supprimerDetail(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        detailDevisService.removeDetailDevis(id);
        redirectAttributes.addFlashAttribute("message", "Détail supprimé.");
        return "redirect:/devis/liste";
    }

    @GetMapping("/demande/{ref}")
    @ResponseBody
    public Map<String, Object> demandeParRef(@PathVariable("ref") String ref) {
        Demande demande = demandeService.getDemandeByRef(ref);
        Map<String, Object> response = new HashMap<>();
        response.put("found", demande != null);
        response.put("demande", demande);
        return response;
    }

    @PostMapping("/ajouter")
    public String ajouterDevis(
            @RequestParam("refDemande") String refDemande,
            @RequestParam("idTypeDevis") int idTypeDevis,
            @RequestParam("libelles") List<String> libelles,
            @RequestParam("unites") List<String> unites,
            @RequestParam("quantites") List<String> quantites,
            @RequestParam("prixUnitaires") List<String> prixUnitaires,
            @RequestParam("descriptions") List<String> descriptions,
            RedirectAttributes redirectAttributes) {

        Demande demande = demandeService.getDemandeByRef(refDemande);
        if (demande == null) {
            redirectAttributes.addFlashAttribute("error", "Référence demande introuvable.");
            return "redirect:/devis/nouveau";
        }

        TypeDevis typeDevis = devisService.findAllTypeDevis().stream()
                .filter(t -> t.getIdTypeDevis() != null && t.getIdTypeDevis() == idTypeDevis)
                .findFirst()
                .orElse(null);

        if (typeDevis == null) {
            redirectAttributes.addFlashAttribute("error", "Type de devis introuvable.");
            return "redirect:/devis/nouveau";
        }

        Devis devis = new Devis();
        devis.setObservation("Devis créé depuis l'interface");

        List<DetailDevis> details = new java.util.ArrayList<>();
        for (int i = 0; i < libelles.size(); i++) {
            DetailDevis detail = new DetailDevis();
            detail.setLibelle(libelles.get(i));
            detail.setUnite(unites.get(i));
            detail.setDescription(descriptions.get(i));
            try {
                detail.setQuantite(new java.math.BigDecimal(quantites.get(i)));
            } catch (Exception e) {
                detail.setQuantite(java.math.BigDecimal.ZERO);
            }
            try {
                detail.setPrix_unitaire(new java.math.BigDecimal(prixUnitaires.get(i)));
            } catch (Exception e) {
                detail.setPrix_unitaire(java.math.BigDecimal.ZERO);
            }
            details.add(detail);
        }

        devisService.saveAll(demande.getId_demande(), devis, details, typeDevis);
        redirectAttributes.addFlashAttribute("message", "Devis enregistré avec succès.");
        return "redirect:/devis/nouveau";
    }
}
