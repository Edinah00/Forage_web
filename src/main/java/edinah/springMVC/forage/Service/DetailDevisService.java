package edinah.springMVC.forage.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edinah.springMVC.forage.Model.DetailDevis;
import edinah.springMVC.forage.Repository.DetailDevisRepository;
import java.util.List;
@Service
public class DetailDevisService {
    @Autowired
    private DetailDevisRepository detailDevisRepository;
    @Autowired
    private  DetailDevis detailDevis;

    public DetailDevis saveDetailDevis(DetailDevis detailDevis) {
        return detailDevisRepository.save(detailDevis);
    }
    public List<DetailDevis> findByIdDevis(int id) {
        return detailDevisRepository.findByDevisId(id);
    }
    public void removeDetailDevis(int id) {
        detailDevisRepository.deleteById(id);
    }   
    


}
