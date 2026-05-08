package edinah.springMVC.forage.Repository;

import edinah.springMVC.forage.Model.Demande;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DemandeRepository extends JpaRepository<Demande, Integer> {
}
