package edinah.springMVC.forage.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edinah.springMVC.forage.Model.Demande;
import edinah.springMVC.forage.Service.DemandeService;
import edinah.springMVC.forage.Repository.ClientRepository;
import edinah.springMVC.forage.Repository.CommuneRepository;

/**
 * CORRECTIONS :
 *  - refuserDemande() appelle demandeService.refuserDemande() (méthode renommée)
 *  - ref_demande n'est plus dans le formulaire (générée côté service)
 *  - modifier : on passe clients et communes pour les selects
 */
@Controller
public class DemandeController {

    @Autowired private DemandeService    demandeService;
    @Autowired private ClientRepository  clientRepository;
    @Autowired private CommuneRepository communeRepository;

    @GetMapping("/formulaire")
    public String afficherFormulaire(Model model) {
        model.addAttribute("demande",  new Demande());
        model.addAttribute("demandes", demandeService.listerDemandes());
        model.addAttribute("clients",  clientRepository.findAll());
        model.addAttribute("communes", communeRepository.findAll());
        return "form_demande";
    }

    @PostMapping("/Ajout_demande")
    public String ajouterDemande(@ModelAttribute("demande") Demande d,
                                 RedirectAttributes redirectAttributes) {
        int id = demandeService.ajouterDemande(d);
        redirectAttributes.addFlashAttribute("message",
            "✅ Demande enregistrée avec succès ! ID = " + id);
        return "redirect:/formulaire";
    }

    @GetMapping("/demandes")
    public String listerDemandes(Model model) {
        model.addAttribute("demandes", demandeService.listerDemandes());
        return "liste_demande";
    }

    @GetMapping("/demande/{id:\\d+}")
    public String detailDemande(@PathVariable("id") int id, Model model) {
        model.addAttribute("demande", demandeService.getDemande(id));
        return "detail_demande";
    }

    @GetMapping("/demande/ref/{ref}")
    public String detailDemandeByRef(@PathVariable("ref") String ref, Model model) {
        model.addAttribute("demande", demandeService.getDemandeByRef(ref));
        return "detail_demande";
    }

    @GetMapping("/demande/modifier/{id}")
    public String afficherFormulaireModification(@PathVariable("id") int id, Model model) {
        model.addAttribute("demande",  demandeService.getDemande(id));
        model.addAttribute("clients",  clientRepository.findAll());   // ← AJOUTÉ
        model.addAttribute("communes", communeRepository.findAll());  // ← AJOUTÉ
        return "edit_demande";
    }

    @PostMapping("/demande/modifier")
    public String modifierDemande(@ModelAttribute("demande") Demande d,
                                  RedirectAttributes redirectAttributes) {
        demandeService.modifierDemande(d);
        redirectAttributes.addFlashAttribute("message", "✅ Demande modifiée avec succès.");
        return "redirect:/formulaire";
    }

    @GetMapping("/demande/supprimer/{id}")
    public String supprimerDemande(@PathVariable("id") int id,
                                   RedirectAttributes redirectAttributes) {
        demandeService.supprimerDemande(id);
        redirectAttributes.addFlashAttribute("message", "🗑️ Demande supprimée.");
        return "redirect:/formulaire";
    }

    @GetMapping("/demande/valider/{id}")
    public String validerDemande(@PathVariable("id") int id,
                                 RedirectAttributes redirectAttributes) {
        demandeService.validerDemande(id);
        redirectAttributes.addFlashAttribute("message", "✅ Demande acceptée.");
        return "redirect:/formulaire";
    }

    /** CORRECTION : appelle refuserDemande (renommé depuis refuséDemande) */
    @GetMapping("/demande/refuser/{id}")
    public String refuserDemande(@PathVariable("id") int id,
                                 RedirectAttributes redirectAttributes) {
        demandeService.refuserDemande(id); // ← CORRIGÉ
        redirectAttributes.addFlashAttribute("message", "❌ Demande refusée.");
        return "redirect:/formulaire";
    }
}