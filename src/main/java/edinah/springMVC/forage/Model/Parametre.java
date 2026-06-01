package edinah.springMVC.forage.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "parametre")
public class Parametre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_parametre")
    private Integer idParametre;

    @Column(name = "id_status1")
    private Integer idStatus1;

    @Column(name = "id_status2")
    private Integer idStatus2;

    @Column(name = "duree")
    private Long duree;

    @Column(name = "couleur")
    private String couleur;

    public Integer getIdParametre() {
        return idParametre;
    }

    public void setIdParametre(Integer idParametre) {
        this.idParametre = idParametre;
    }

    public Integer getIdStatus1() {
        return idStatus1;
    }

    public void setIdStatus1(Integer idStatus1) {
        this.idStatus1 = idStatus1;
    }

    public Integer getIdStatus2() {
        return idStatus2;
    }

    public void setIdStatus2(Integer idStatus2) {
        this.idStatus2 = idStatus2;
    }

    public Long getDuree() {
        return duree;
    }

    public void setDuree(Long duree) {
        this.duree = duree;
    }

    public String getCouleur() {
        return couleur;
    }

    public void setCouleur(String couleur) {
        this.couleur = couleur;
    }
}
