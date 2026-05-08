package edinah.springMVC.forage.Repository;

import edinah.springMVC.forage.Model.Commune;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommuneRepository extends JpaRepository<Commune, Integer> {
}
