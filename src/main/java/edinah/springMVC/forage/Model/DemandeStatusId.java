package edinah.springMVC.forage.Model;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class DemandeStatusId implements Serializable {

    private static final long serialVersionUID = 1L;

    @Column(name = "id_demande")
    private int id_demande;

    @Column(name = "id_status")
    private int id_status;

    public DemandeStatusId() {
    }

    public DemandeStatusId(int id_demande, int id_status) {
        this.id_demande = id_demande;
        this.id_status = id_status;
    }

    public int getId_demande() {
        return id_demande;
    }

    public void setId_demande(int id_demande) {
        this.id_demande = id_demande;
    }

    public int getId_status() {
        return id_status;
    }

    public void setId_status(int id_status) {
        this.id_status = id_status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        DemandeStatusId that = (DemandeStatusId) o;
        return id_demande == that.id_demande && id_status == that.id_status;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id_demande, id_status);
    }
}
