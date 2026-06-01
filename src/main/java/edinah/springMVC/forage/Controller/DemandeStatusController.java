package edinah.springMVC.forage.Controller;

import java.util.List;
import java.util.Locale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edinah.springMVC.forage.Model.*;
import edinah.springMVC.forage.Service.*;

@Controller
public class DemandeStatusController {
    @Autowired
    private DemandeStatusService demandeStatusService;
    @Autowired  
    private DemandeService demandeService;

    // GET: formulaire d'ajout
    @GetMapping("/form_demande_status")
    public String formAjouterDemandeStatus(Model model) {
        model.addAttribute("demandeStatus", new DemandeStatus());
        model.addAttribute("demandes", demandeService.listerDemandes());
        model.addAttribute("statuses", demandeStatusService.getStatusMapper().MapperStatus());
        return "form_demande_status";
    }

    // POST: ajouter demande status
    @PostMapping("/demande_status/ajouter")
    public String ajouterDemandeStatus(DemandeStatus demandeStatus, RedirectAttributes redirectAttributes) {
        try {
            demandeStatusService.ajouterDemandeStatus(demandeStatus);
            redirectAttributes.addFlashAttribute("message", "Statut de demande ajouté avec succès.");
            return "redirect:/form_demande_status";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erreur", "Erreur lors de l'ajout : " + e.getMessage());
            return "redirect:/form_demande_status";
        }
    }

    // GET: liste des demandes status
    @GetMapping("/demande_status/liste")
    public String listDemandeStatus(Model model) {
        model.addAttribute("demandesStatus", demandeStatusService.listerDemandesStatus());
        model.addAttribute("statuses", demandeStatusService.getStatusMapper().MapperStatus());
        return "liste_demande_status";
    }

    // GET: formulaire de modification
    @GetMapping("/demande_status/modifier/{idDemande}/{idStatus}")
    public String formModifierDemandeStatus(
        @PathVariable("idDemande") int idDemande,
        @PathVariable("idStatus") int idStatus,
        Model model) {
        
        DemandeStatus demandeStatus = demandeStatusService.getDemande(idDemande, idStatus);
        if (demandeStatus == null) {
            return "redirect:/demande_status/liste";
        }
        
        model.addAttribute("demandeStatus", demandeStatus);
        model.addAttribute("demandes", demandeService.listerDemandes());
        model.addAttribute("statuses", demandeStatusService.getStatusMapper().MapperStatus());
        model.addAttribute("previousStatuses", demandeStatusService.findByDemande(idDemande));
        
        return "edit_demande_status";
    }

    // POST: modifier demande status
    @PostMapping("/demande_status/modifier")
    public String modifierDemandeStatus(DemandeStatus demandeStatus, RedirectAttributes redirectAttributes) {
        try {
            demandeStatusService.modifierDemandeStatus(demandeStatus);
            redirectAttributes.addFlashAttribute("message", "Statut de demande modifié avec succès.");
            return "redirect:/demande_status/liste";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erreur", "Erreur lors de la modification : " + e.getMessage());
            return "redirect:/demande_status/liste";
        }
    }

    // GET: supprimer demande status
    @GetMapping("/demande_status/supprimer/{idDemande}/{idStatus}")
    public String supprimerDemandeStatus(
        @PathVariable("idDemande") int idDemande,
        @PathVariable("idStatus") int idStatus,
        RedirectAttributes redirectAttributes) {
        
        try {
            demandeStatusService.supprimerDemande(idDemande, idStatus);
            redirectAttributes.addFlashAttribute("message", "Statut de demande supprimé avec succès.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("erreur", "Erreur lors de la suppression : " + e.getMessage());
        }
        
        return "redirect:/demande_status/liste";
    }

    // GET: API pour charger les statuses déjà assignés à une demande
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
        
        return ResponseEntity.ok()
            .contentType(MediaType.APPLICATION_JSON)
            .body(json.toString());
    }
}