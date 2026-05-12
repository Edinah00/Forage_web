
// ── DetailDevisRepository.java ────────────────────────────────────────────────
package edinah.springMVC.forage.Repository;

import edinah.springMVC.forage.Model.DetailDevis;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface DetailDevisRepository extends JpaRepository<DetailDevis, Integer> {
    List<DetailDevis> findByIdDevis(int idDevis);
    void deleteByIdDevis(int idDevis);
}
