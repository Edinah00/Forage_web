package edinah.springMVC.forage.Repository;

import edinah.springMVC.forage.Model.DemandeStatus;
import edinah.springMVC.forage.Model.DemandeStatusId;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DemandeStatusRepository extends JpaRepository<DemandeStatus, DemandeStatusId> {
}
