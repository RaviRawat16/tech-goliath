public class PatternDisplay {
    public static void Pattern(Integer num){
        string pattern1=' ' ;
        string pattern2=' ' ;
        string pattern3=' ' ;
        for(integer i = 0; i<num;i++){
            pattern1=pattern1+'=';
        }
        for(integer i = 0; i<(num*2);i++){
            pattern2=pattern2+'-';
        }
        for(integer i = 0; i<num;i++){
            pattern3=pattern3+'=';
        }
        system.debug(pattern1);
        system.debug(pattern2);
        system.debug(pattern3);
    }
}
