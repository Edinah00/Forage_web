package edinah.springMVC.forage.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import edinah.springMVC.forage.Model.*;
import edinah.springMVC.forage.Service.*;

@Controller
public class DemandeController {
    
    @Autowired
    private DemandeService demandeService;

    @GetMapping("/formulaire")
    public String afficherFormulaire(Model model) {
        model.addAttribute("demande", new Demande()); // ✅ objet vide envoyé à la vue
        return "form_demande";
    }

    @PostMapping("/Ajout_demande")                    // ✅ POST pas GET pour un ajout
    public String ajouterDemande(@ModelAttribute("demande") Demande d, Model model) {
        int idDemande = demandeService.ajouterDemande(d);
        model.addAttribute("message", "Demande ajoutée avec succès ! ID = " + idDemande);
        return "succes";
    }

    @GetMapping("/demandes")
    public String listerDemandes(Model model) {
        model.addAttribute("demandes", demandeService.listerDemandes());
        return "liste_demande";
    }

    @GetMapping("/demande/{id}")
    public String detailDemande(@PathVariable("id") int id, Model model) {
        model.addAttribute("demande", demandeService.getDemande(id));
        return "detail_demande";
    }

    @PostMapping("/demande/modifier")
    public String modifierDemande(@ModelAttribute("demande") Demande d) {
        demandeService.modifierDemande(d);
        return "redirect:/demandes";
    }

    @GetMapping("/demande/supprimer/{id}")
    public String supprimerDemande(@PathVariable("id") int id) {
        demandeService.supprimerDemande(id);
        return "redirect:/demandes";
    }

}
