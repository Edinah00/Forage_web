// ── StatusDevisRepository.java ────────────────────────────────────────────────
package edinah.springMVC.forage.Repository;

import edinah.springMVC.forage.Model.StatusDevis;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StatusDevisRepository extends JpaRepository<StatusDevis, Integer> {}

