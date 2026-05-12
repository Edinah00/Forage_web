// ── DevisStatusId.java ────────────────────────────────────────────────────────
package edinah.springMVC.forage.Model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class DevisStatusId implements Serializable {
    private static final long serialVersionUID = 1L;

    @Column(name = "id_devis")        private int id_devis;
    @Column(name = "id_status_devis") private int id_status_devis;

    public DevisStatusId() {}
    public DevisStatusId(int id_devis, int id_status_devis) {
        this.id_devis        = id_devis;
        this.id_status_devis = id_status_devis;
    }

    public int getId_devis()             { return id_devis; }
    public void setId_devis(int v)       { this.id_devis = v; }
    public int getId_status_devis()      { return id_status_devis; }
    public void setId_status_devis(int v){ this.id_status_devis = v; }

    @Override public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof DevisStatusId)) return false;
        DevisStatusId t = (DevisStatusId) o;
        return id_devis == t.id_devis && id_status_devis == t.id_status_devis;
    }
    @Override public int hashCode() { return Objects.hash(id_devis, id_status_devis); }
}
