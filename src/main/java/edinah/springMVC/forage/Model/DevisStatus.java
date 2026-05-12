package edinah.springMVC.forage.Model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "devis_status")
public class DevisStatus {

    @EmbeddedId
    private DevisStatusId id;

    @Column(name = "date_status")
    private LocalDateTime date_status;

    public DevisStatus() {}
    public DevisStatus(int id_devis, int id_status_devis, LocalDateTime date_status) {
        this.id          = new DevisStatusId(id_devis, id_status_devis);
        this.date_status = date_status;
    }

    public DevisStatusId getId()              { return id; }
    public void setId(DevisStatusId v)        { this.id = v; }

    public LocalDateTime getDate_status()     { return date_status; }
    public void setDate_status(LocalDateTime v){ this.date_status = v; }

    public int getId_devis()                  { return id != null ? id.getId_devis() : 0; }
    public int getId_status_devis()           { return id != null ? id.getId_status_devis() : 0; }
}
