package edinah.springMVC.forage.Model;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "devis")
public class Devis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_devis")
    private int idDevis;

    @Column(name = "id_demande")
    private int idDemande;

    @Column(name = "date_devis")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateDevis;

    // ── getters / setters ──────────────────────────────────
    public int getId_devis()              { return idDevis; }
    public void setId_devis(int v)        { this.idDevis = v; }

    public int getIdDevis()               { return idDevis; }
    public void setIdDevis(int v)         { this.idDevis = v; }

    public int getId_demande()            { return idDemande; }
    public void setId_demande(int v)      { this.idDemande = v; }

    public int getIdDemande()             { return idDemande; }
    public void setIdDemande(int v)       { this.idDemande = v; }

    public LocalDate getDate_devis()      { return dateDevis; }
    public void setDate_devis(LocalDate v){ this.dateDevis = v; }

    public LocalDate getDateDevis()       { return dateDevis; }
    public void setDateDevis(LocalDate v) { this.dateDevis = v; }
}
