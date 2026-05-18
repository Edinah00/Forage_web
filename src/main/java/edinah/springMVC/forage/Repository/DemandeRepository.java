package edinah.springMVC.forage.Repository;

import edinah.springMVC.forage.Model.Demande;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DemandeRepository extends JpaRepository<Demande, Integer> {
    @Query("SELECT d FROM Demande d WHERE d.ref_demande = :refDemande")
    Optional<Demande> findByRefDemande(@Param("refDemande") String refDemande);
}
