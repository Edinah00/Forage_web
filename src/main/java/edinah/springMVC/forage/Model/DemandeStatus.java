package edinah.springMVC.forage.Model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * CORRECTIONS :
 *  - PK séquentielle (id INT AUTO_INCREMENT) au lieu de la clé composite (id_demande, id_status)
 *    → permet d'assigner plusieurs fois le même statut à une demande (ex: deux refus successifs)
 *  - @Transient duree_travail_minutes et couleur conservés pour le calcul à la volée
 */
@Entity
@Table(name = "demande_status")
public class DemandeStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "id_demande", nullable = false)
    private Integer id_demande;

    @Column(name = "id_status", nullable = false)
    private Integer id_status;

    @Column(name = "observation", length = 255)
    private String observation;

    @Column(name = "date_status", nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime date_status;

    @Transient
    private Long duree_travail_minutes;

    @Transient
    private String couleur;

    // ── Getters / Setters ─────────────────────────────────────────

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getId_demande() { return id_demande; }
    public void setId_demande(Integer id_demande) { this.id_demande = id_demande; }

    public Integer getId_status() { return id_status; }
    public void setId_status(Integer id_status) { this.id_status = id_status; }

    public String getObservation() { return observation; }
    public void setObservation(String observation) { this.observation = observation; }

    public LocalDateTime getDate_status() { return date_status; }
    public void setDate_status(LocalDateTime date_status) { this.date_status = date_status; }

    public Long getDuree_travail_minutes() { return duree_travail_minutes; }
    public void setDuree_travail_minutes(Long duree_travail_minutes) {
        this.duree_travail_minutes = duree_travail_minutes;
    }

    public String getCouleur() { return couleur; }
    public void setCouleur(String couleur) { this.couleur = couleur; }
}