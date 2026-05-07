package edinah.springMVC.forage.Model;

public class Demande {
    private int id_demande;
    private String ref_demande;
    private String id_client;
    private String lieu_demande;
    private String id_commune;
    private String date_demande;  // ✅ String, plus simple

    public int getId_demande() { return id_demande; }
    public void setId_demande(int id_demande) { this.id_demande = id_demande; }

    public String getDate_demande() { return date_demande; }
    public void setDate_demande(String date_demande) { this.date_demande = date_demande; }

    public String getId_client() { return id_client; }
    public void setId_client(String id_client) { this.id_client = id_client; }

    public String getId_commune() { return id_commune; }
    public void setId_commune(String id_commune) { this.id_commune = id_commune; }

    public String getLieu_demande() { return lieu_demande; }
    public void setLieu_demande(String lieu_demande) { this.lieu_demande = lieu_demande; }

    public String getRef_demande() { return ref_demande; }
    public void setRef_demande(String ref_demande) { this.ref_demande = ref_demande; }
}
