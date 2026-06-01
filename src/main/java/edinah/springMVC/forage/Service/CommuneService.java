
 package edinah.springMVC.forage.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edinah.springMVC.forage.Model.Commune;
import edinah.springMVC.forage.Repository.CommuneRepository;

@Service
public class CommuneService {
    @Autowired
    private CommuneRepository communeRepository;

    public List<Commune> ListCommune(){
        return communeRepository.findAll();
    }

    public Commune findById(int id){
        return communeRepository.findById(id).orElse(null);
    }  
}