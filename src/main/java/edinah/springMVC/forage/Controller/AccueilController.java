package edinah.springMVC.forage.Controller;

import edinah.springMVC.forage.Repository.ClientRepository;
import edinah.springMVC.forage.Service.DemandeService;
import edinah.springMVC.forage.Service.DevisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AccueilController {

    @Autowired private DemandeService  demandeService;
    @Autowired private DevisService    devisService;
    @Autowired private ClientRepository clientRepo;

    @GetMapping({"/", "/accueil"})
    public String accueil(Model model) {
        long totalDemandes    = demandeService.listerDemandes().size();
        long demandesAcceptees = demandeService.listerDemandes().stream()
            .filter(d -> devisService.demandeEstAcceptee(d.getId_demande()))
            .count();
        long totalDevis  = devisService.listerDevis().size();
        long totalClients = clientRepo.count();

        model.addAttribute("totalDemandes",     totalDemandes);
        model.addAttribute("demandesAcceptees", demandesAcceptees);
        model.addAttribute("totalDevis",        totalDevis);
        model.addAttribute("totalClients",      totalClients);
        return "accueil";
    }
}
