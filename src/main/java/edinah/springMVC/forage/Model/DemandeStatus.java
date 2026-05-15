package edinah.springMVC.forage.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Table;
import java.util.Map;
import java.time.LocalDateTime;

@Entity
@Table(name = "demande_status")
public class DemandeStatus {

    @EmbeddedId
    private DemandeStatusId id;

    @Column(name = "date_status")
    private LocalDateTime date_status;

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

    public int getId_demande() {
        return id != null ? id.getId_demande() : 0;
    }

    public int getId_status() {
        return id != null ? id.getId_status() : 0;
    }

    public void setId_demande(int id_demande) {
        if (id == null) {
            id = new DemandeStatusId();
        }
        id.setId_demande(id_demande);
    }

    public void setId_status(int id_status) {
        if (id == null) {
            id = new DemandeStatusId();
        }
        id.setId_status(id_status);
    }
    
}
