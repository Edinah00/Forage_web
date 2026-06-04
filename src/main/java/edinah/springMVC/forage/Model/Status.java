package edinah.springMVC.forage.Model;

import jakarta.persistence.*;

/**
 * CORRECTION : ajout des getters et setters manquants
 */
@Entity
@Table(name = "status")
public class Status {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_status")
    private int idStatus;

    @Column(name = "libelle")
    private String libelle;

    public int getIdStatus() { return idStatus; }
    public void setIdStatus(int idStatus) { this.idStatus = idStatus; }

    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
}