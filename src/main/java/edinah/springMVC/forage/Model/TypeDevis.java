package edinah.springMVC.forage.Model;

import java.util.HashMap;
import java.util.Map;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "type_devis")
public class TypeDevis {
    @Column(name = "id_type_devis")
    private Integer idTypeDevis;
    @Column(name = "libelle")
    private String libelle;

    private String sigle;

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