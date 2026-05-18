package edinah.springMVC.forage.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edinah.springMVC.forage.Model.*;
import edinah.springMVC.forage.Service.*;
import edinah.springMVC.forage.Repository.ClientRepository;
import edinah.springMVC.forage.Repository.CommuneRepository;

@Controller
public class DemandeController {
    
    @Autowired
    private DemandeService demandeService;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private CommuneRepository communeRepository;
    
    @GetMapping("/formulaire")
    public String afficherFormulaire(Model model) {
        model.addAttribute("demande", new Demande()); // ✅ objet vide envoyé à la vue
        model.addAttribute("demandes", demandeService.listerDemandes());
        model.addAttribute("clients", clientRepository.findAll());
        model.addAttribute("communes", communeRepository.findAll());
        return "form_demande";
    }

    @PostMapping("/Ajout_demande")                    // ✅ POST pas GET pour un ajout
    public String ajouterDemande(@ModelAttribute("demande") Demande d, RedirectAttributes redirectAttributes) {
        int idDemande = demandeService.ajouterDemande(d);
        redirectAttributes.addFlashAttribute("message", "Demande ajoutée avec succès ! ID = " + idDemande);
        return "redirect:/formulaire";
    }

    @GetMapping("/demandes")
    public String listerDemandes(Model model) {
        model.addAttribute("demandes", demandeService.listerDemandes());
        model.addAttribute("clients", clientRepository.findAll());
        model.addAttribute("communes", communeRepository.findAll());
        return "liste_demande";
    }

    @GetMapping("/demande/{id}")
    public String detailDemande(@PathVariable("id") int id, Model model) {
        model.addAttribute("demande", demandeService.getDemande(id));
        return "detail_demande";
    }
    @GetMapping("/demande/{ref}")
    public String detailDemande(@PathVariable("ref") String ref, Model model) {
        model.addAttribute("demande", demandeService.getDemandeByRef(ref));
        return "detail_demande";
    }

    @GetMapping("/demande/modifier/{id}")
    public String afficherFormulaireModification(@PathVariable("id") int id, Model model) {
        model.addAttribute("demande", demandeService.getDemande(id));
        return "edit_demande";
    }

    @PostMapping("/demande/modifier")
    public String modifierDemande(@ModelAttribute("demande") Demande d) {
        demandeService.modifierDemande(d);
        return "redirect:/formulaire";
    }

    @GetMapping("/demande/supprimer/{id}")
    public String supprimerDemande(@PathVariable("id") int id) {
        demandeService.supprimerDemande(id);
        return "redirect:/formulaire";
    }
    @GetMapping("/demande/valider/{id}")
    public String validerDemande(@PathVariable("id") int id) {
        demandeService.validerDemande(id);
        return "redirect:/formulaire";
    }
    @GetMapping("/demande/refuser/{id}")
    public String refuserDemande(@PathVariable("id") int id) {
        demandeService.refuséDemande(id);
        return "redirect:/formulaire";
    }

}
