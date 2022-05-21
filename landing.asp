<!-- #include file='constend/constanta.asp' -->
<div class="collapse" id="navbarToggleExternalContent">
  <div class="bg-dark p-4 navbar-button">
    <ul class="icon-list">
        <li class="icon-item">
          <% if session("HL")=true then %>
            <a href="<%=url%>/dashboard.asp" class="icon-link">
              <i class="fa fa-home" aria-hidden="true"></i>DASHBOARD
            </a>
          <% end if %>
        </li>
        <li class="icon-item" style="margin-right:25px;padding:0;">
          <% if session("HA1") = true then %>
          <a href="<%=url%>/index.asp" class="icon-link" style="display:flex;flex-direction:row;width: 178px;">
            <i class="fa fa-users" aria-hidden="true"></i>MASTER KARYAWAN
          </a>
          <% else %>
            <span></span>
          <%end if%>
        </li>
        <li class="icon-item">
          <% if session("HA3")=true then %>
          <a href="<%=url%>/masterShift" class="icon-link">          
            <i class="fa fa-shirtsinbulk" aria-hidden="true"></i>MASTER SHIFT
          </a>
          <% end if %>
        </li>
        <li class="icon-item">
        <% if session("HA2")=true then %>
          <a href="<%=url%>/shift_view.asp" class="icon-link" style="display:flex;flex-direction:row;width: 160px;">           
            <i class="fa fa-briefcase" aria-hidden="true"></i>
            <span>
              SHIFT KARYAWAN
            </span>
          </a>
          <% end if %>
        </li>
        <li class="icon-item">
          <% if session("HA4")=true then %>
          <a href="<%=url%>/divisi" class="icon-link">        
            <i class="fa fa-clipboard" aria-hidden="true"></i>DIVISI
          </a>
          <% end if %>
        </li>
        <li class="icon-item">
           <% if session("HA5")=true then %>
          <a href="<%=url%>/jenjang" class="icon-link">            
            <i class="fa fa-level-up" aria-hidden="true"></i>JENJANG
          </a>
          <% end if %>
        </li>
        <li class="icon-item">
          <% if session("HA6")=true then %>
          <a href="<%=url%>/jabatan" class="icon-link">            
            <i class="fa fa-handshake-o" aria-hidden="true"></i>JABATAN
          </a>
          <% end if %>
        </li>
        <%if session("HA8") = true then%>
        <li class="icon-item">
          <a href="<%=url%>/transaksi" class="icon-link">            
            <i class="fa fa-cog" aria-hidden="true"></i>TRANSAKSI
          </a>
        </li>
        <%end if%>
        <li class="icon-item">
          <a href="<%=url%>/logout.asp" class="icon-link">
            <i class="fa fa-sign-out" aria-hidden="true"></i>LOGOUT
          </a>
        </li>
      </ul>
    </div>
  </div>
</div>
<nav class="navbar navbar-dark bg-dark">
  <div class="container-fluid navbar-logo">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <img src="<%=url%>/logo/landing.PNG" style="Max-width:130px;margin-right:10px;" class="dakotaLogo">
  </div>
</nav>

<!--slide bar end-->
<!--content start-->

