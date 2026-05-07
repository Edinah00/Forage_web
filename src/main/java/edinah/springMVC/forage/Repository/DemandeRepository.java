package edinah.springMVC.forage.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import edinah.springMVC.forage.Model.Demande;

@Repository
public class DemandeRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int save(Demande d) {
        String sql = "INSERT INTO demande (ref_demande, id_client, lieu_demande, id_commune, date_demande) VALUES (?, ?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, new String[] {"id_demande"});
            ps.setString(1, d.getRef_demande());
            ps.setInt(2, Integer.parseInt(d.getId_client()));
            ps.setString(3, d.getLieu_demande());
            ps.setInt(4, Integer.parseInt(d.getId_commune()));
            ps.setTimestamp(5, toTimestamp(d.getDate_demande()));
            return ps;
        }, keyHolder);

        Number id = keyHolder.getKey();
        if (id != null) {
            insertInitialStatus(id.intValue());
            d.setId_demande(id.intValue());
            return id.intValue();
        }
        return 0;
    }

    public List<Demande> findAll() {
        String sql = "SELECT id_demande, ref_demande, id_client, lieu_demande, id_commune, date_demande FROM demande ORDER BY id_demande DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> mapDemande(rs));
    }

    public Demande findById(int idDemande) {
        String sql = "SELECT id_demande, ref_demande, id_client, lieu_demande, id_commune, date_demande FROM demande WHERE id_demande = ?";
        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapDemande(rs), idDemande);
    }

    public int update(Demande d) {
        String sql = "UPDATE demande SET ref_demande = ?, id_client = ?, lieu_demande = ?, id_commune = ?, date_demande = ? WHERE id_demande = ?";
        return jdbcTemplate.update(sql,
                d.getRef_demande(),
                Integer.parseInt(d.getId_client()),
                d.getLieu_demande(),
                Integer.parseInt(d.getId_commune()),
                toTimestamp(d.getDate_demande()),
                d.getId_demande());
    }

    public int delete(int idDemande) {
        jdbcTemplate.update("DELETE FROM demande_status WHERE id_demande = ?", idDemande);
        return jdbcTemplate.update("DELETE FROM demande WHERE id_demande = ?", idDemande);
    }

    private void insertInitialStatus(int idDemande) {
        Integer idStatus = jdbcTemplate.query(
                "SELECT id_status FROM status WHERE libelle = ?",
                rs -> rs.next() ? rs.getInt("id_status") : null,
                "Demande créée");

        if (idStatus == null) {
            jdbcTemplate.update("INSERT INTO status (libelle) VALUES (?)", "Demande créée");
            idStatus = jdbcTemplate.query(
                    "SELECT id_status FROM status WHERE libelle = ?",
                    rs -> rs.next() ? rs.getInt("id_status") : null,
                    "Demande créée");
        }

        if (idStatus != null) {
            jdbcTemplate.update(
                    "INSERT INTO demande_status (id_demande, id_status, date_status) VALUES (?, ?, NOW())",
                    idDemande, idStatus);
        }
    }

    private Timestamp toTimestamp(String dateDemande) {
        if (dateDemande == null || dateDemande.isBlank()) {
            return null;
        }
        return Timestamp.valueOf(dateDemande + " 00:00:00");
    }

    private Demande mapDemande(ResultSet rs) throws SQLException {
        Demande d = new Demande();
        d.setId_demande(rs.getInt("id_demande"));
        d.setRef_demande(rs.getString("ref_demande"));
        d.setId_client(String.valueOf(rs.getInt("id_client")));
        d.setLieu_demande(rs.getString("lieu_demande"));
        d.setId_commune(String.valueOf(rs.getInt("id_commune")));
        Timestamp ts = rs.getTimestamp("date_demande");
        d.setDate_demande(ts == null ? null : ts.toLocalDateTime().toLocalDate().toString());
        return d;
    }
}
