package edinah.springMVC.forage.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import edinah.springMVC.forage.Model.Devis;
@Repository
public interface DevisRepository extends JpaRepository<Devis, Integer> {
    
}
