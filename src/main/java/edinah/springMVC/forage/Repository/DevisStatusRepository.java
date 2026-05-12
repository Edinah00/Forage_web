// ── DevisStatusRepository.java ────────────────────────────────────────────────
package edinah.springMVC.forage.Repository;

import edinah.springMVC.forage.Model.DevisStatus;
import edinah.springMVC.forage.Model.DevisStatusId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface DevisStatusRepository extends JpaRepository<DevisStatus, DevisStatusId> {
    List<DevisStatus> findByIdIdDevis(int idDevis);
    Optional<DevisStatus> findTopByIdIdDevisOrderByDateStatusDesc(int idDevis);
}