package edinah.springMVC.forage.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import edinah.springMVC.forage.Model.Parametre;

/**
 * Logique couleur basée UNIQUEMENT sur la durée travaillée :
 *  - Chercher les seuils <= durée travaillée
 *  - Prendre le plus HAUT (celui qui s'applique vraiment)
 *  Exemple : durée = 120 min
 *    Seuils : 100 (vert), 150 (jaune), 200 (rouge)
 *    Candidats : 100 <= 120 → {100}
 *    Résultat : 100 (vert) ✓
 */
@Repository
public interface ParametreRepository extends JpaRepository<Parametre, Integer> {

    @Query("""
            SELECT p FROM Parametre p
            WHERE p.duree <= :duree
            ORDER BY p.duree DESC
            """)
    List<Parametre> findApplicableParams(
            @Param("duree") Long duree);
}