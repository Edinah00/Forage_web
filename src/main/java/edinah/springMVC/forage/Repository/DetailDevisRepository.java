package edinah.springMVC.forage.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import edinah.springMVC.forage.Model.DetailDevis;
@Repository
public interface DetailDevisRepository extends JpaRepository<DetailDevis, Integer> {
    @Query("SELECT d FROM DetailDevis d WHERE d.devis.id_devis = :idDevis")
    java.util.List<DetailDevis> findByDevisId(Integer idDevis);
}
