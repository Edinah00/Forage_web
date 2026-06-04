package edinah.springMVC.forage.Controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edinah.springMVC.forage.Model.Demande;
import edinah.springMVC.forage.Model.DemandeStatus;
import edinah.springMVC.forage.Model.DetailDevis;
import edinah.springMVC.forage.Model.Devis;
import edinah.springMVC.forage.Model.TypeDevis;
import edinah.springMVC.forage.Model.Utils;
import edinah.springMVC.forage.Service.DemandeService;
import edinah.springMVC.forage.Service.DemandeStatusService;
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

    @Autowired
    private DemandeStatusService demandeStatusService;

    @GetMapping
    public String index() {
        return "redirect:/devis/nouveau";
    }

    @GetMapping("/nouveau")
    public String nouveau(Model model) {
        model.addAttribute("devis", new Devis());
        model.addAttribute("typesDevis", devisService.findAllTypeDevis());
        model.addAttribute("demandes", demandeService.listerDemandes());
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
    public ResponseEntity<String> demandeParRef(@PathVariable("ref") String ref) {
        Demande demande = demandeService.getDemandeByRef(ref);
        if (demande == null) {
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body("{\"found\":false,\"demande\":null,\"peut_forage\":false,\"dernier_status_id\":null}");
        }

        List<DemandeStatus> historique = demandeStatusService.findByDemande(demande.getId_demande());
        Integer dernierStatusId = historique.isEmpty() ? null : historique.get(historique.size() - 1).getId_status();
        boolean peutForage = historique.stream().anyMatch(status -> Integer.valueOf(3).equals(status.getId_status()));

        String json = String.format(Locale.ROOT,
                "{\"found\":true,\"demande\":{\"id_demande\":%d,\"ref_demande\":%s,\"id_client\":%s,\"id_commune\":%s,\"lieu_demande\":%s,\"date_demande\":%s},\"peut_forage\":%s,\"dernier_status_id\":%s}",
                demande.getId_demande(),
                jsonString(demande.getRef_demande()),
                demande.getId_client() == null ? "null" : demande.getId_client().toString(),
                demande.getId_commune() == null ? "null" : demande.getId_commune().toString(),
                jsonString(demande.getLieu_demande()),
                jsonString(demande.getDate_demande() == null ? null : demande.getDate_demande().toString()),
                peutForage ? "true" : "false",
                dernierStatusId == null ? "null" : dernierStatusId.toString()
        );
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(json);
    }

    private String jsonString(String value) {
        if (value == null) {
            return "null";
        }
        return "\"" + value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t") + "\"";
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

        List<DemandeStatus> historique = demandeStatusService.findByDemande(demande.getId_demande());
        boolean peutForage = historique.stream().anyMatch(status -> Integer.valueOf(3).equals(status.getId_status()));

        TypeDevis typeDevis = devisService.findAllTypeDevis().stream()
                .filter(t -> t.getIdTypeDevis() != null && t.getIdTypeDevis() == idTypeDevis)
                .findFirst()
                .orElse(null);

        if (typeDevis == null) {
            redirectAttributes.addFlashAttribute("error", "Type de devis introuvable.");
            return "redirect:/devis/nouveau";
        }

        Utils utils = new Utils();
        int idStatus = utils.ChercherIdStatus(typeDevis);
        if (idStatus == 5 && !peutForage) {
            redirectAttributes.addFlashAttribute("error", "Le devis Forage est disponible seulement après le statut DEC.");
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
