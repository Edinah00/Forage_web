package edinah.springMVC.forage.Repository;

import edinah.springMVC.forage.Model.Demande;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface DemandeRepository extends JpaRepository<Demande, Integer> {

    @Query("SELECT d FROM Demande d WHERE TRIM(d.ref_demande) = TRIM(:refDemande)")
    Optional<Demande> findByRefDemande(@Param("refDemande") String refDemande);

    /**
     * CORRECTION : compte les demandes ayant au moins un statut "Acceptée" (id_status = 2)
     */
    @Query("""
            SELECT COUNT(DISTINCT ds.id_demande)
            FROM DemandeStatus ds
            WHERE ds.id_status = 2
            """)
    long countAcceptees();
}