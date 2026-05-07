package edinah.springMVC.forage.Model;

public class DemandeStatus {
    private int id_status;
    private int id_demande;
    private String status; 

    public int getId_status() { return id_status; }
    public void setId_status(int id_status) { this.id_status = id_status; }

    public int getId_demande() { return id_demande; }
    public void setId_demande(int id_demande) { this.id_demande = id_demande; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}