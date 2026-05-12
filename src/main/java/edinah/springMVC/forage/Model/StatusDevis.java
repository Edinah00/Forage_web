package edinah.springMVC.forage.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "status_devis")
public class StatusDevis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_status_devis")
    private int id_status_devis;

    @Column(name = "libelle")
    private String libelle;

    public int getId_status_devis()          { return id_status_devis; }
    public void setId_status_devis(int v)    { this.id_status_devis = v; }

    public String getLibelle()               { return libelle; }
    public void setLibelle(String v)         { this.libelle = v; }
}
