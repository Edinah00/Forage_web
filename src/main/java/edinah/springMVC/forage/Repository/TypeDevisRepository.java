package edinah.springMVC.forage.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import edinah.springMVC.forage.Model.TypeDevis;
@Repository
public interface TypeDevisRepository extends JpaRepository<TypeDevis,Integer>{
    
}
