class Data
{
  class FILE
  {
    String filename;
    int commit_count;

    int deletion;
    int addition;

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

  JSONObject idtoname;
  JSONObject filename_numbering;
  int filename_numbering_count;
  FILE[] file = new FILE[MAX];

  Data ()
  {
    idtoname = new JSONObject ();
    filename_numbering = new JSONObject ();
    filename_numbering_count = 0 ;
  }
  
  PImage load_avatar (String pp_id)
  {
    File imaged = new File ( "/Users/choikeunjun/Desktop/Project/main/avatar/" + pp_id + ".png" ) ;
    if ( !imaged.exists() )
    {
      loadImage ("https://secure.gravatar.com/avatar/" + pp_id + "?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png", "png").save("/Users/choikeunjun/Desktop/Project/main/avatar/" + pp_id + ".png");
    }
    return loadImage ( "/Users/choikeunjun/Desktop/Project/main/avatar/" + pp_id + ".png" ) ;
  }
  
  boolean avatar_isexists (String pp_id)
  {
    File imaged = new File ( "/Users/choikeunjun/Desktop/Project/main/avatar/" + pp_id + ".png" ) ;
    if ( imaged.exists() )
    {
      return true;
    }
    loadImage ("https://secure.gravatar.com/avatar/" + pp_id + "?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png", "png").save("/Users/choikeunjun/Desktop/Project/main/avatar/" + pp_id + ".png");
    return false;
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
      if ( filename_numbering.getInt (fn) == -1)
      {
        filename_numbering.put (fn, filename_numbering_count);
        file[filename_numbering_count] = new FILE ();
        file[filename_numbering_count].filename = fn;
        file[filename_numbering_count].h=random (randomHue-0.1, randomHue+0.1); 
        file[filename_numbering_count].s=random (0.27, 0.35);
        file[filename_numbering_count].b=random (0.2, 0.9);

        filename_numbering_count ++;
      }
      int x = filename_numbering.getInt (fn);
      file[x].commit_count ++;
      int temp ;
      temp = files.getJSONObject(i).getInt("deletions");
      if ( temp != -1 ) file[x].deletion += temp;
      temp = files.getJSONObject(i).getInt("additions");
      if ( temp != -1 ) file[x].addition += temp;
      if ( pp_id != "" )
      {
        if ( file[x].ppname_numbering.getInt (pp_id) == -1)
        {
          avatar_isexists(pp_id);
          file[x].ppname_numbering.put(pp_id, file[x].ppname_numbering_count);
          file[x].ppname_numbering_count++;
        }
        int y = file[x].ppname_numbering.getInt (pp_id);
        file[x].ppid[y] = pp_id;
        file[x].ppcount[y]++;
      }
    }
  }
}

