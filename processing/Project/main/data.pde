class Data
{
  class FILE
  {
    String filename;
    int commit_count;

    int deletion;
    int addition;

    int syear;
    int smonth;

    int[][] count = new int[120*12][32];
    int[] count_year_sum = new int[120*12];

    JSONObject ppname_numbering;
    int ppname_numbering_count;
    String[] ppid = new String[MAX];
    int[] ppcount = new int[MAX];

    float h, s, b;

    FILE ()
    {
      ppname_numbering = new JSONObject ();
      deletion = addition = 0;
      commit_count = 0;
      ppname_numbering_count = 0 ;
    }
  }

  int[][] count = new int[120*12][32];
  int[] count_year_sum = new int[120*12];

  int[] deletion = new int[120*12*5];
  int[] addition = new int[120*12*5];
  
  float[][] ppco = new float[PPMAX][3];

  int min, max;

  JSONObject idtoname;
  JSONObject filename_numbering;
  int filename_numbering_count;
  FILE[] file = new FILE[MAX];

  JSONObject ppname_numbering;
  int ppname_numbering_count;
  int[][] ppname_deletion = new int[PPMAX][120*12*5];
  int[][] ppname_addition = new int[PPMAX][120*12*5];
  String[] ppname_list = new String[PPMAX];
  PImage[] av = new PImage[PPMAX];

  Data ()
  {
    min = 120*12*5+1;
    max = -1;

    idtoname = new JSONObject ();
    filename_numbering = new JSONObject ();
    filename_numbering_count = 0 ;

    ppname_numbering = new JSONObject ();
    ppname_numbering_count = 0 ;
  }

  PImage load_avatar (String pp_id)
  {
    File imaged = new File ( "/Users/choikeunjun/Desktop/Project/main/avatar/" + pp_id + ".png" ) ;
    int y;
    if ( !imaged.exists() )
    {
      y = ppname_numbering.getInt (pp_id);
      av[y] = new PImage ();
      av[y] = loadImage ("https://secure.gravatar.com/avatar/" + pp_id + "?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png", "png");
      av[y].save("/Users/choikeunjun/Desktop/Project/main/avatar/" + pp_id + ".png");
    }
    y = ppname_numbering.getInt (pp_id);
    return av[y] ;
  }

  boolean avatar_isexists (String pp_id)
  {
    File imaged = new File ( "/Users/choikeunjun/Desktop/Project/main/avatar/" + pp_id + ".png" ) ;
    int y = ppname_numbering.getInt (pp_id);
    if ( imaged.exists() )
    {
      if ( av[y] == null )
      {
        av[y] = loadImage ( "/Users/choikeunjun/Desktop/Project/main/avatar/" + pp_id + ".png" );
      }
      return true;
    }
    av[y] = new PImage ();
    av[y] = loadImage ("https://secure.gravatar.com/avatar/" + pp_id + "?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png", "png");
    av[y].save("/Users/choikeunjun/Desktop/Project/main/avatar/" + pp_id + ".png");
    return false;
  }

  int get_number_of_line ( String e )
  {
    int count = 1;
    int i, size = e .length ();
    for ( i = 0 ; i < size ; i ++ )
    {
      if ( e .charAt (i) == '\n' ) count ++ ;
    }
    return count ;
  }

  void add_data (JSONObject element)
  {
    tab1_new = true;
    JSONArray files = element.getJSONArray("files");
    int i, size = files.length ();
    String pp_id = "";
    if ( element.getJSONObject("author") != null )
    {
      pp_id = element.getJSONObject("author").getString("gravatar_id");
    }
    if (idtoname.getString(pp_id) == "") idtoname.put(pp_id, element.getJSONObject("commit").getJSONObject("author").getString("name"));
    for ( i = 0 ; i < size ; i ++ )
    {
      String fn = files.getJSONObject(i).getString("filename");

      SimpleDateFormat formatt = new SimpleDateFormat ( "yyyy-MM-dd'T'hh:mm:ss'Z'", Locale.ENGLISH );
      ParsePosition pos = new ParsePosition ( 0 );
      Date dd = formatt.parse ( element.getJSONObject("commit").getJSONObject("author").getString("date"), pos );

      if ( filename_numbering.getInt (fn) == -1)
      {
        filename_numbering.put (fn, filename_numbering_count);
        file[filename_numbering_count] = new FILE ();
        file[filename_numbering_count].filename = fn;
        file[filename_numbering_count].h=random (randomHue-0.1, randomHue+0.1); 
        file[filename_numbering_count].s=random (0.27, 0.35);
        file[filename_numbering_count].b=random (0.2, 0.9);

        file[filename_numbering_count].syear = dd.getYear();
        file[filename_numbering_count].smonth = dd.getMonth();

        filename_numbering_count ++;
      }
      int x = filename_numbering.getInt (fn);
      file[x].commit_count ++;
      file[x].count[dd.getYear()*12+dd.getMonth()][dd.getDate()]++;
      file[x].count_year_sum[dd.getYear()*12+dd.getMonth()]++;
      count[dd.getYear()*12+dd.getMonth()][dd.getDate()]++;
      count_year_sum[dd.getYear()*12+dd.getMonth()]++;
      int temp ;
      if (min > (dd.getYear()*12+dd.getMonth())*5+(dd.getDate()/7)) min = (dd.getYear()*12+dd.getMonth())*5+(dd.getDate()/7);
      if (max < (dd.getYear()*12+dd.getMonth())*5+(dd.getDate()/7)) max = (dd.getYear()*12+dd.getMonth())*5+(dd.getDate()/7);
      int ll = get_number_of_line ( files.getJSONObject(i).getString("patch") );
      temp = files.getJSONObject(i).getInt("deletions");
      if ( temp != -1 )
      {
        file[x].deletion += temp;
        deletion[(dd.getYear()*12+dd.getMonth())*5+(dd.getDate()/7)] += temp;
      }
      temp = files.getJSONObject(i).getInt("additions");
      if ( temp != -1 )
      {
        file[x].addition += temp;
        addition[(dd.getYear()*12+dd.getMonth())*5+(dd.getDate()/7)] += temp;
      }
      if ( pp_id != "" )
      {
        if (ppname_numbering.getInt (pp_id) == -1)
        {
          ppname_numbering.put(pp_id, ppname_numbering_count);
          ppname_list[ppname_numbering_count] = pp_id;
          avatar_isexists(pp_id);
          ppco[ppname_numbering_count][0] = randomHue + random (0, 0.6) - 0.3;
          if(ppco[ppname_numbering_count][0] < 0) ppco[ppname_numbering_count][0] = 1 - ppco[ppname_numbering_count][0];
          if(ppco[ppname_numbering_count][0] > 1.0) ppco[ppname_numbering_count][0] = ppco[ppname_numbering_count][0] - 1;
          ppco[ppname_numbering_count][1] = random (0.2, 0.7);
          ppco[ppname_numbering_count][2] = random (0.1, 0.9);
          ppname_numbering_count++;
        }
        int y = ppname_numbering.getInt (pp_id);
        temp = files.getJSONObject(i).getInt("deletions");
        if ( temp != -1 )
        {
          ppname_deletion[y][(dd.getYear()*12+dd.getMonth())*5+(dd.getDate()/7)] += temp;
        }
        temp = files.getJSONObject(i).getInt("additions");
        if ( temp != -1 )
        {
          ppname_addition[y][(dd.getYear()*12+dd.getMonth())*5+(dd.getDate()/7)] += temp;
        }

        if ( file[x].ppname_numbering.getInt (pp_id) == -1)
        {
          avatar_isexists(pp_id);
          file[x].ppname_numbering.put(pp_id, file[x].ppname_numbering_count);
          file[x].ppname_numbering_count++;
        }
        y = file[x].ppname_numbering.getInt (pp_id);
        file[x].ppid[y] = pp_id;
        file[x].ppcount[y]++;
      }
    }
  }
}

