package edinah.springMVC.forage.Model;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "type_devis")
public class TypeDevis {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_type_devis")
    private Integer idTypeDevis;
    @Column(name = "libelle")
    private String libelle;


    public Integer getIdTypeDevis() {
        return idTypeDevis;
    }

    public void setIdTypeDevis(Integer idTypeDevis) {
        this.idTypeDevis = idTypeDevis;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }


}
