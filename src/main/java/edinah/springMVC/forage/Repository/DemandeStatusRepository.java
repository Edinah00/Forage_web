// package edinah.springMVC.forage.Repository;

// import java.util.List;

// import edinah.springMVC.forage.Model.DemandeStatus;
// import edinah.springMVC.forage.Model.DemandeStatusId;

// import org.springframework.data.jpa.repository.JpaRepository;
// import org.springframework.data.jpa.repository.Query;
// import org.springframework.data.repository.query.Param;
// import org.springframework.stereotype.Repository;

// @Repository
// public interface DemandeStatusRepository extends JpaRepository<DemandeStatus, DemandeStatusId> {

//     @Query("SELECT ds FROM DemandeStatus ds WHERE ds.id.id_demande = :idDemande")
//     List<DemandeStatus> findByDemandeId(@Param("idDemande") int idDemande);

//     @Query("SELECT ds FROM DemandeStatus ds ORDER BY ds.id.id_demande ASC, ds.date_status ASC, ds.id.id_status ASC")
//     List<DemandeStatus> findAllOrderByDemandeAndDate();
// }
package edinah.springMVC.forage.Repository;

import java.util.List;

import edinah.springMVC.forage.Model.DemandeStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 * CORRECTION : plus de clé composite DemandeStatusId — PK est maintenant Integer (id auto)
 */
@Repository
public interface DemandeStatusRepository extends JpaRepository<DemandeStatus, Integer> {

    @Query("SELECT ds FROM DemandeStatus ds WHERE ds.id_demande = :idDemande ORDER BY ds.date_status ASC")
    List<DemandeStatus> findByDemandeId(@Param("idDemande") int idDemande);

    @Query("SELECT ds FROM DemandeStatus ds ORDER BY ds.id_demande ASC, ds.date_status ASC, ds.id_status ASC")
    List<DemandeStatus> findAllOrderByDemandeAndDate();
}