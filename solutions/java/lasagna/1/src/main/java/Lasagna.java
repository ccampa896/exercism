public class Lasagna {

    public static final int MINUTES_IN_OVEN = 40;
    
    public int expectedMinutesInOven(){
        return MINUTES_IN_OVEN;
    }

    public int remainingMinutesInOven(int pastMinutes){
        return MINUTES_IN_OVEN - pastMinutes;
    }

    public int preparationTimeInMinutes(int amountOfLayers){
        return 2 * amountOfLayers;
    }

    public int totalTimeInMinutes(int amountOfLayers, int pastMinutes){
        return preparationTimeInMinutes(amountOfLayers) + pastMinutes;
    }
}
