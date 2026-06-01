package edinah.springMVC.forage.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Transient;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "demande_status")
public class DemandeStatus {

    @EmbeddedId
    private DemandeStatusId id;

    @Column(name = "observation")
    private String observation;

    @Column(name = "date_status")
    private LocalDateTime date_status;

    @Transient
    private Long duree_travail_minutes;

    @Transient
    private String couleur;

    public DemandeStatusId getId() {
        return id;
    }

    public void setId(DemandeStatusId id) {
        this.id = id;
    }

    public LocalDateTime getDate_status() {
        return date_status;
    }

    public void setDate_status(LocalDateTime date_status) {
        this.date_status = date_status;
    }

    public Integer getId_demande() {
        return id != null ? id.getId_demande() : null;
    }

    public Integer getId_status() {
        return id != null ? id.getId_status() : null;
    }

    public void setId_demande(Integer id_demande) {
        if (id == null) {
            id = new DemandeStatusId();
        }
        id.setId_demande(id_demande);
    }

    public void setId_status(Integer id_status) {
        if (id == null) {
            id = new DemandeStatusId();
        }
        id.setId_status(id_status);
    }
    public String getObservation() {
        return observation;
    }
    public void setObservation(String observation) {
        this.observation = observation;
    }

    public Long getDuree_travail_minutes() {
        return duree_travail_minutes;
    }

    public void setDuree_travail_minutes(Long duree_travail_minutes) {
        this.duree_travail_minutes = duree_travail_minutes;
    }

    public String getCouleur() {
        return couleur;
    }

    public void setCouleur(String couleur) {
        this.couleur = couleur;
    }
    
    
}
