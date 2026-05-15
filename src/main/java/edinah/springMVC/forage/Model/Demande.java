package edinah.springMVC.forage.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Entity
@Table(name = "demande")
public class Demande {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_demande")
    private int id_demande;

    @Column(name = "ref_demande")
    private String ref_demande;

    // Après
    @Column(name = "id_client")
    private Integer id_client;

    @Column(name = "id_commune")
    private Integer id_commune;

    @Column(name = "lieu_demande")
    private String lieu_demande;

  
    @Column(name = "date_demande")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate date_demande;

    public int getId_demande() {
        return id_demande;
    }

    public void setId_demande(int id_demande) {
        this.id_demande = id_demande;
    }

    public LocalDate getDate_demande() {
        return date_demande;
    }

    public void setDate_demande(LocalDate date_demande) {
        this.date_demande = date_demande;
    }

    public Integer getId_client() {
        return id_client;
    }

    public void setId_client(Integer id_client) {
        this.id_client = id_client;
    }

    public Integer getId_commune() {
        return id_commune;
    }

    public void setId_commune(Integer id_commune) {
        this.id_commune = id_commune;
    }

    public String getLieu_demande() {
        return lieu_demande;
    }

    public void setLieu_demande(String lieu_demande) {
        this.lieu_demande = lieu_demande;
    }

    public String getRef_demande() {
        return ref_demande;
    }

    public void setRef_demande(String ref_demande) {
        this.ref_demande = ref_demande;
    }
}
