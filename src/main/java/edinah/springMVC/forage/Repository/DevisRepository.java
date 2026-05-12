package edinah.springMVC.forage.Repository;
import edinah.springMVC.forage.Model.Devis;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface DevisRepository extends JpaRepository<Devis, Integer> {
    List<Devis> findByIdDemande(int idDemande);
}

