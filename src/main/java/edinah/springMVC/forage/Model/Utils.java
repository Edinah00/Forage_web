package edinah.springMVC.forage.Model;

import java.util.HashMap;
import java.util.Map;

public class Utils {
    
    public Map<String, Integer> MapperType() {

        Map<String, Integer> map = new HashMap<>();

        map.put("DEC", 1);
        map.put("DFC", 2);

        return map;
    }

    public Map<String, Integer> MapperStatus() {

        Map<String, Integer> map = new HashMap<>();

        map.put("DC", 1);
        map.put("DA", 2);
        map.put("DR", 3);
        map.put("DEC", 4);
        map.put("DER", 5);
        map.put("DFC", 6);
        map.put("DFR", 7);

        return map;
    }

    public String chercherSigleType(TypeDevis typeDevis) {

        int id_type = typeDevis.getIdTypeDevis();

        Map<String, Integer> mapType = MapperType();

        for (Map.Entry<String, Integer> entry : mapType.entrySet()) {

            if (entry.getValue() == id_type) {
                return entry.getKey();
            }
        }

        return null;
    }

    public int ChercherIdStatus(TypeDevis type) {

        String sigleType = chercherSigleType(type);

        Map<String, Integer> mapStatut = MapperStatus();

        return mapStatut.getOrDefault(sigleType, 0);
    }

}