<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <!--<ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>-->
      
      <div class="col-md-4 pull-right dahsboard-cal">
        
<div id="reportrange" class="pull-right " >
<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
<span id="sales-report-range" ></span> <b class="caret"></b>

</div>

<div class="go salesorderstatsGo">
<p>Go</p>

</div>

        </div>
      
    </div>
  </div>
  <div class="ord-info-main">
    <div class="col-md-4">
      <div class="order-info">
      <!--  <h2>Orders Info</h2>-->
        <div class="order-hea">
          <h3>Sales Stats</h3>
        </div>
        <div class="ord-bot">
          <div class="main-sales">
            <div class="col-md-6">
              <p>Sales Amount</p>
            </div>
            <div class="col-md-6">
              <h4 class="SalesAmount"></h4>
            </div>
            <div class="clearfix"></div>
          </div>
          <div class="main-sales">
            <div class="col-md-6">
              <p>Total Orders</p>
            </div>
            <div class="col-md-6">
              <h4 class="sa-bot TotalOrders"></h4>
            </div>
            <div class="clearfix"></div>
          </div>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    
    <div class="col-md-4">
      <div class="order-info">
       <!-- <h2>Orders Info</h2>-->
        <div class="order-hea blue">
          <h3>Total Users</h3>
        </div>
        <div class="ord-bot">
          <div class="main-sales">
            <div class="col-md-6">
              <p>Total Customers</p>
            </div>
            <div class="col-md-6">
              <h4 class="to-cus TotalCustomers"></h4>
            </div>
            <div class="clearfix"></div>
          </div>
          <div class="main-sales">
            <div class="col-md-6">
              <p>Online Users</p>
            </div>
            <div class="col-md-6">
              <h4 class="to-bot TotalCustomersOnline"></h4>
            </div>
            <div class="clearfix"></div>
          </div>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="order-info">
        <!--<h2>Orders Info</h2>-->
        <div class="order-hea cyan">
          <h3>Order Status</h3>
        </div>
        <div class="ord-bot">
          <div class="main-sales">
            <div class="col-md-6">
              <p>Orders Pening</p>
            </div>
            <div class="col-md-6">
              <h4 class="or-st PendingOrdes"></h4>
            </div>
            <div class="clearfix"></div>
          </div>
          <div class="main-sales">
            <div class="col-md-6">
              <p>Orders Returned</p>
            </div>
            <div class="col-md-6">
              <h4 class="or-sat ReturnedOrders"></h4>
            </div>
            <div class="clearfix"></div>
          </div>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    
    
    
    <div class="clearfix"></div>
  </div>
  
  
  
  
  <div class="col-md-12 mb">
  <div class="sales-ana sales-calendar">
  
  <div class="col-md-6 pl">
  <h2>Sales & Order Analysis</h2>
  </div>
 
 <div class="col-md-6 pr">
  <div id="sales-reportrange" class="pull-right sale-range " >
		<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
        	<span id="sales-report-range" class="salesreportrange" ></span> <b class="caret"></b>
   </div>

	<div class="go sales-order-analysis-go"> <p>Go</p> </div>
    </div>
     <div class="clearfix"></div>
  <div class="salesanalysis" id="sales-order-analysis">
  
  </div>
  
  
  </div>
  
  <div class="clearfix"></div>
  
  </div>
  
  
  
  
<div class="col-xs-6 col-sm-6 col-md-6">
                <div class="card">
                    <div class="header">
                        <h2>Top Selling</h2>
                        <!--<ul class="header-dropdown m-r--5">
                            <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="zmdi zmdi-more-vert"></i></a>
                                <ul class="dropdown-menu pull-right">
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Action</a></li>
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Another action</a></li>
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Something else here</a></li>
                                </ul>
                            </li>
                        </ul>-->
                    </div>
                    <div class="body">
                        <div class="table-responsive">
                            <table class="table table-hover dashboard-task-infos">
                                <thead>
                                    <tr>
                                        <th align="left"><strong>Category</strong></th>
                                        <th><strong>Product Name</strong></th>
                                        <th><strong>Quantity</strong></th>
                                        <th><strong>Sales Amount</strong></th>
                                       
                                    </tr>
                                </thead>
                                
                                 <tbody id="topsales">
                                 
                                 </tbody>
                                
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6">
                <div class="card">
                    <div class="header">
                        <h2 class="most">Most Viewed</h2>
                        <!--<ul class="header-dropdown m-r--5">
                            <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="zmdi zmdi-more-vert"></i></a>
                                <ul class="dropdown-menu pull-right">
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Action</a></li>
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Another action</a></li>
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Something else here</a></li>
                                </ul>
                            </li>
                        </ul>-->
                    </div>
                    <div class="body">
                        <div class="table-responsive">
                            <table class="table table-hover dashboard-task-infos">
                                <thead>
                                    <tr>
                                        <th><strong>Category</strong></th>
                                        <th><strong>Product Name</strong></th>
                                        <th><strong>Views</strong></th>
                                        <th><strong>Last Viewed</strong></th>
                                       
                                    </tr>
                                </thead>
                                
                                 <tbody id="mostviewed">
                                 
                                 </tbody>
                                 
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="clearfix"></div>
            <div class="col-xs-6 col-sm-6 col-md-6">
                <div class="card">
                    <div class="header">
                        <h2 class="clos-stk">Closing Stock</h2>
                        <!--<ul class="header-dropdown m-r--5">
                            <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="zmdi zmdi-more-vert"></i></a>
                                <ul class="dropdown-menu pull-right">
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Action</a></li>
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Another action</a></li>
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Something else here</a></li>
                                </ul>
                            </li>
                        </ul>-->
                    </div>
                    <div class="body">
                        <div class="table-responsive">
                            <table class="table table-hover dashboard-task-infos">
                                <thead>
                                    <tr>
                                        <th>Category</th>
                                        <th>Product Name</th>
                                        <th>Sales</th>
                                        <th>In Stock</th>
                                       
                                    </tr>
                                </thead>
                                <tbody id="closingstock">
                                    <tr>
                                        <td>1</td>
                                        <td>Task A</td>
                                        
                                        <td>15263</td>
                                        <td><span class="label bg-green">3</span></td>
                                       
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Task B</td>
                                       
                                        <td>15263</td>
                                         <td><span class="label bg-blue">2</span></td>
                                        
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Task C</td>
                                       
                                        <td>15263</td>
                                         <td><span class="label bg-light-blue">5%</span></td>
                                        
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>Task D</td>
                                        
                                        <td>15263</td>
                                        <td><span class="label bg-orange">5</span></td>
                                        
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>Task E</td>
                                       
                                        <td>15263</td>
                                         <td><span class="label bg-red">8</span></td>
                                       
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            
            <div class="col-xs-6 col-sm-6 col-md-6">
                <div class="card">
                    <div class="header">
                        <h2 class="new-re">New Reviews</h2>
                        <!--<ul class="header-dropdown m-r--5">
                            <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="zmdi zmdi-more-vert"></i></a>
                                <ul class="dropdown-menu pull-right">
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Action</a></li>
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Another action</a></li>
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Something else here</a></li>
                                </ul>
                            </li>
                        </ul>-->
                    </div>
                    <div class="body">
                        <div class="table-responsive">
                            <table class="table table-hover dashboard-task-infos">
                                <thead>
                                    <tr>
                                        <th>Customer</th>
                                        <th>Product Name</th>
                                        <th>Review</th>
                                        <th>Action</th>
                                       
                                    </tr>
                                </thead>
                                <tbody id="newreviews">
                                
                                </tbody>
                                
                            </table>
                        </div>
                    </div>
                </div>
            </div>
  
 <!-- <div class="col-xs-6 col-sm-6 col-md-6">
                <div class="card">
                    <div class="header">
                        <h2>TASK INFOS</h2>
                        <ul class="header-dropdown m-r--5">
                            <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="zmdi zmdi-more-vert"></i></a>
                                <ul class="dropdown-menu pull-right">
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Action</a></li>
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Another action</a></li>
                                    <li><a href="javascript:void(0);" class=" waves-effect waves-block">Something else here</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="body">
                        <div class="table-responsive">
                            <table class="table table-hover dashboard-task-infos">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Task</th>
                                        <th>Status</th>
                                        <th>Professors</th>
                                        <th>Progress</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Task A</td>
                                        <td><span class="label bg-green">Doing</span></td>
                                        <td>John Doe</td>
                                        <td><div class="progress m-b-0">
                                                <div class="progress-bar bg-green" role="progressbar" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100" style="width: 62%"></div>
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Task B</td>
                                        <td><span class="label bg-blue">To Do</span></td>
                                        <td>John Doe</td>
                                        <td><div class="progress m-b-0">
                                                <div class="progress-bar bg-blue" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%"></div>
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Task C</td>
                                        <td><span class="label bg-light-blue">On Hold</span></td>
                                        <td>John Doe</td>
                                        <td><div class="progress m-b-0">
                                                <div class="progress-bar bg-light-blue" role="progressbar" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100" style="width: 72%"></div>
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>Task D</td>
                                        <td><span class="label bg-orange">Wait Approvel</span></td>
                                        <td>John Doe</td>
                                        <td><div class="progress m-b-0">
                                                <div class="progress-bar bg-orange" role="progressbar" aria-valuenow="95" aria-valuemin="0" aria-valuemax="100" style="width: 95%"></div>
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>Task E</td>
                                        <td><span class="label bg-red">Suspended</span></td>
                                        <td>John Doe</td>
                                        <td><div class="progress m-b-0">
                                                <div class="progress-bar bg-red" role="progressbar" aria-valuenow="87" aria-valuemin="0" aria-valuemax="100" style="width: 87%"></div>
                                            </div></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>-->
  
<?php echo $footer; ?>