<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script> 
<script language="JavaScript" type="text/javascript">var dynpath = '/razuna';</script>
<link rel="stylesheet" type="text/css" href="/razuna/global/js/jquery-ui-1.8.21.custom/css/smoothness/jquery-ui-1.8.21.custom.css?_v=2012.09.02.1" />
<link rel="stylesheet" type="text/css" href="/razuna/global/host/dam/views/layouts/main.css?_v=2012.09.02.1" />
<link rel="stylesheet" type="text/css" href="/razuna/global/host/dam/views/layouts/error.css?_v=2012.09.02.1" />
<link rel="stylesheet" type="text/css" href="/razuna/global/videoplayer/css/multiple-instances.css?_v=2012.09.02.1" />
<link rel="stylesheet" type="text/css" href="/razuna/global/js/tag/css/jquery.tagit.css?_v=2012.09.02.1" />
<link rel="stylesheet" type="text/css" href="/razuna/global/host/dam/views/layouts/tagit.css?_v=2012.09.02.1" />
<link rel="stylesheet" type="text/css" href="/razuna/global/js/notification/sticky.min.css?_v=2012.09.02.1" />
<link rel="stylesheet" type="text/css" href="/razuna/global/js/chosen/chosen.css?_v=2012.09.02.1" />
<script type="text/javascript" src="/razuna/global/js/jquery-1.7.2.min.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/jquery.validate.min.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/jquery.form.min.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/jquery-ui-1.8.21.custom/js/jquery-ui-1.8.21.custom.min.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/videoplayer/js/flowplayer-3.2.6.min.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/AC_QuickTime.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/jqtree/lib/jquery.cookie.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/host/dam/js/global.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/jqtree/jquery.tree.min.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/jqtree/plugins/jquery.tree.cookie.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/tag/js/tag-it.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/notification/sticky.min.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/chosen/chosen.jquery.min.js?_v=2012.09.02.1"></script>
<script type="text/javascript" src="/razuna/global/js/jquery.formparams.js?_v=2012.09.02.1"></script>
<link rel="SHORTCUT ICON" href="/razuna/global/host/dam/images/favicon.ico" />
</head>
<body>


<script type="text/javascript">


    $(document).ready(function(){
        $.ajax({
            url:  "index.cfm?fa=c.images_detail&file_id=<%=request.getParameter("file_id")%>&what=images&loaddiv=container&folder_id=<%=request.getParameter("folder_id") %>&showsubfolders=F",
            cache: false,
            success: function(html){
                $("#content").append(html);
            }
        });
    });
</script>
<div id="content"> 
</div>
</body>

</html>
