package edinah.springMVC.forage.Model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "detail_devis")
public class DetailDevis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_detail")
    private int id_detail;

    @Column(name = "id_devis")
    private int id_devis;

    @Column(name = "libelle")
    private String libelle;

    @Column(name = "unite")
    private String unite;

    @Column(name = "quantite")
    private BigDecimal quantite;

    @Column(name = "prix_unitaire")
    private BigDecimal prix_unitaire;

    @Column(name = "description")
    private String description;

    // montant est une colonne générée (STORED) – lecture seule depuis Java
    @Column(name = "montant", insertable = false, updatable = false)
    private BigDecimal montant;

    // ── getters / setters ──────────────────────────────────
    public int getId_detail()                   { return id_detail; }
    public void setId_detail(int v)             { this.id_detail = v; }

    public int getId_devis()                    { return id_devis; }
    public void setId_devis(int v)              { this.id_devis = v; }

    public String getLibelle()                  { return libelle; }
    public void setLibelle(String v)            { this.libelle = v; }

    public String getUnite()                    { return unite; }
    public void setUnite(String v)              { this.unite = v; }

    public BigDecimal getQuantite()             { return quantite; }
    public void setQuantite(BigDecimal v)       { this.quantite = v; }

    public BigDecimal getPrix_unitaire()        { return prix_unitaire; }
    public void setPrix_unitaire(BigDecimal v)  { this.prix_unitaire = v; }

    public String getDescription()              { return description; }
    public void setDescription(String v)        { this.description = v; }

    public BigDecimal getMontant()              { return montant; }
    public void setMontant(BigDecimal v)        { this.montant = v; }

    // Calcul côté Java (pour l'affichage avant persistance)
    public BigDecimal getMontantCalcule() {
        if (quantite != null && prix_unitaire != null) {
            return quantite.multiply(prix_unitaire);
        }
        return BigDecimal.ZERO;
    }
}
