package edinah.springMVC.forage.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import edinah.springMVC.forage.Model.Parametre;

@Repository
public interface ParametreRepository extends JpaRepository<Parametre, Integer> {

    @Query("""
            SELECT p FROM Parametre p
            WHERE p.idStatus1 = :idStatus1
              AND p.idStatus2 = :idStatus2
              AND p.duree <= :duree
            ORDER BY p.duree DESC
            """)
    List<Parametre> findApplicableParams(
            @Param("idStatus1") Integer idStatus1,
            @Param("idStatus2") Integer idStatus2,
            @Param("duree") Long duree);
}
