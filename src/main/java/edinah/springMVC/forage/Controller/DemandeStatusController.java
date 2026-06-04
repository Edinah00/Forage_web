package edinah.springMVC.forage.Controller;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edinah.springMVC.forage.Model.Demande;
import edinah.springMVC.forage.Model.DemandeStatus;
import edinah.springMVC.forage.Service.DemandeService;
import edinah.springMVC.forage.Service.DemandeStatusService;

/**
 * CORRECTION : plus de clé composite — les routes /modifier et /supprimer
 *              utilisent l'id séquentiel au lieu de (idDemande, idStatus)
 */
@Controller
public class DemandeStatusController {

    @Autowired private DemandeStatusService demandeStatusService;
    @Autowired private DemandeService       demandeService;

    // ── Formulaire ajout ─────────────────────────────────────────

    @GetMapping("/form_demande_status")
    public String formAjouterDemandeStatus(Model model) {
        model.addAttribute("demandeStatus", new DemandeStatus());
        model.addAttribute("demandes",      demandeService.listerDemandes());
        model.addAttribute("statuses",      demandeStatusService.getStatusMapper().MapperStatus());
        return "form_demande_status";
    }

    @PostMapping("/demande_status/ajouter")
    public String ajouterDemandeStatus(DemandeStatus demandeStatus,
                                       RedirectAttributes redirectAttributes) {
        try {
            demandeStatusService.ajouterDemandeStatus(demandeStatus);
            redirectAttributes.addFlashAttribute("message", "✅ Statut ajouté avec succès.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erreur", "❌ Erreur : " + e.getMessage());
        }
        return "redirect:/form_demande_status";
    }

    // ── Liste ────────────────────────────────────────────────────

    @GetMapping("/demande_status/liste")
    public String listDemandeStatus(Model model) {
        model.addAttribute("demandesStatus", demandeStatusService.listerDemandesStatus());
        model.addAttribute("statuses",       demandeStatusService.getStatusMapper().MapperStatus());
        return "liste_demande_status";
    }

    // ── Modification ─────────────────────────────────────────────

    /**
     * CORRECTION : route basée sur l'id séquentiel (au lieu de /idDemande/idStatus)
     */
    @GetMapping("/demande_status/modifier/{id}")
    public String formModifierDemandeStatus(@PathVariable("id") int id, Model model) {
        DemandeStatus ds = demandeStatusService.getDemande(id);
        if (ds == null) return "redirect:/demande_status/liste";

        model.addAttribute("demandeStatus",    ds);
        model.addAttribute("demandes",         demandeService.listerDemandes());
        model.addAttribute("statuses",         demandeStatusService.getStatusMapper().MapperStatus());
        model.addAttribute("previousStatuses", demandeStatusService.findByDemande(ds.getId_demande()));
        return "edit_demande_status";
    }

    @PostMapping("/demande_status/modifier")
    public String modifierDemandeStatus(DemandeStatus demandeStatus,
                                        RedirectAttributes redirectAttributes) {
        try {
            demandeStatusService.modifierDemandeStatus(demandeStatus);
            redirectAttributes.addFlashAttribute("message", "✅ Statut modifié avec succès.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erreur", "❌ Erreur : " + e.getMessage());
        }
        return "redirect:/demande_status/liste";
    }

    // ── Suppression ──────────────────────────────────────────────

    /**
     * CORRECTION : route basée sur l'id séquentiel
     */
    @GetMapping("/demande_status/supprimer/{id}")
    public String supprimerDemandeStatus(@PathVariable("id") int id,
                                         RedirectAttributes redirectAttributes) {
        try {
            demandeStatusService.supprimerDemande(id);
            redirectAttributes.addFlashAttribute("message", "🗑️ Statut supprimé.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erreur", "❌ Erreur : " + e.getMessage());
        }
        return "redirect:/demande_status/liste";
    }

    // ── API JSON ─────────────────────────────────────────────────

    @GetMapping("/demande_status/statuses/{idDemande}")
    @ResponseBody
    public ResponseEntity<String> getPreviousStatuses(@PathVariable("idDemande") int idDemande) {
        List<DemandeStatus> statusList = demandeStatusService.findByDemande(idDemande);
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < statusList.size(); i++) {
            if (i > 0) json.append(",");
            json.append(statusList.get(i).getId_status());
        }
        json.append("]");
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(json.toString());
    }

    @GetMapping("/demande_status/api")
    @ResponseBody
    public ResponseEntity<String> getDemandeStatuses(
            @RequestParam(value = "ref", required = false) String ref,
            @RequestParam(value = "date", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {

        Demande demande = null;
        List<DemandeStatus> statusList;

        if (ref != null && !ref.isBlank()) {
            demande = demandeService.getDemandeByRef(ref.trim());
            if (demande == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .contentType(MediaType.APPLICATION_JSON)
                        .body("{\"found\":false,\"message\":\"Demande introuvable\"}");
            }
            statusList = demandeStatusService.findByDemande(demande.getId_demande());
            demandeStatusService.prepareStatuses(statusList);
        } else {
            statusList = demandeStatusService.listerDemandesStatus();
        }

        if (date != null) {
            statusList = statusList.stream()
                    .filter(ds -> ds.getDate_status() != null && ds.getDate_status().toLocalDate().equals(date))
                    .collect(Collectors.toList());
        }

        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"found\":true,");
        if (demande != null) {
            json.append("\"demande\":{");
            json.append("\"id_demande\":").append(demande.getId_demande()).append(",");
            json.append("\"ref_demande\":").append(jsonString(demande.getRef_demande())).append(",");
            json.append("\"id_client\":").append(demande.getId_client() == null ? "null" : demande.getId_client()).append(",");
            json.append("\"id_commune\":").append(demande.getId_commune() == null ? "null" : demande.getId_commune()).append(",");
            json.append("\"lieu_demande\":").append(jsonString(demande.getLieu_demande())).append(",");
            json.append("\"date_demande\":").append(jsonString(demande.getDate_demande() == null ? null : demande.getDate_demande().toString()));
            json.append("},");
        } else {
            json.append("\"demande\":null,");
        }
        json.append("\"statuses\":[");
        for (int i = 0; i < statusList.size(); i++) {
            DemandeStatus ds = statusList.get(i);
            if (i > 0) json.append(",");
            json.append("{");
            json.append("\"id\":").append(ds.getId()).append(",");
            json.append("\"id_demande\":").append(ds.getId_demande()).append(",");
            json.append("\"id_status\":").append(ds.getId_status()).append(",");
            json.append("\"observation\":").append(jsonString(ds.getObservation())).append(",");
            json.append("\"date_status\":").append(jsonString(ds.getDate_status() == null ? null : ds.getDate_status().toString())).append(",");
            json.append("\"duree_travail_minutes\":").append(ds.getDuree_travail_minutes() == null ? "null" : ds.getDuree_travail_minutes()).append(",");
            json.append("\"couleur\":").append(jsonString(ds.getCouleur()));
            json.append("}");
        }
        json.append("],");
        json.append("\"total\":").append(statusList.size());
        json.append("}");

        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(json.toString());
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
}
