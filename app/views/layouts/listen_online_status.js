PrivatePub.subscribe("/update_online_status", function(data) {
   if (data.status) {
     $('#online_status_' + data.user_id ).text('YES');
   }
   else {
     $('#online_status_' + data.user_id ).text('NO');
   }
  });
