<?php
	function drawline($color)
	{
		echo "<hr class='$color my-0' style=\"height:3px\"/>";
	}

	function breakLine($times)
	{
		for($i = 0; $i < $times ; $i++)
			echo "</br>";
	}

	echo "<!DOCTYPE html>";
	echo "<html lang='en'>";
		echo "<head>";
			include("header.html");
		echo "</head>";

		echo "<body>";
		include("nav.php");
		echo "<header>";		
		echo "<div id='intro' class='view'>";
			echo "<div class='mask rgba-black-strong'>";
				echo "<div class='container-fluid d-flex align-items-center justify-content-center h-100'>";
					echo "<div class='row d-flex justify-content-center text-center'>";
						echo "<div class='col-md-10'>";
							echo "<h2 class='display-4 font-weight-bold text-light pt-5 mb-2'>LET US HELP YOU CRAFT YOUR FUTURE</h2>";
							drawline("bg-light");
							echo "<h4 class='text-light my-4'>Enabling our students to thrive in college life and BEYOND!</h4>";
							echo "<a class='btn btn-outline-white' href='#college_in_Malaysia'>Find Your Future<i class='fa fa-book ml-2'></i></a>";
						echo "</div>";
					echo "</div>";
				echo "</div>";
			echo "</div>";
		echo "</div>";
		echo "</header>";
			echo "<main class='mt-5'>";
				echo "<div class='container' id='college_in_Malaysia'>";
					echo"<section id='examples' class='text-center'>";
						echo"<h2 class='mb-5 font-weight-bold'>Colleges in Malaysia</h2>";
						echo"<div class='row'>";
							echo"<div class='col-lg-4 col-md-12 mb-4'>";
								echo"<div class='view overlay z-depth-1-half'>";
									echo"<img src='images/home/college-inti.jpg' height=200px width=100% class='img-fluid' alt=''>";
									echo"<div class='mask rgba-white-slight'></div>";
								echo"</div>";
								echo"<h4 class='my-4 font-weight-bold'>INTI College Subang</h4>";
							echo"</div>";

							echo"<div class='col-lg-4 col-md-6 mb-4'>";
								echo"<div class='view overlay z-depth-1-half'>";
									echo"<img src='images/home/college-segi.jpg' height=200px width=100% alt=''>";
									echo"<div class='mask rgba-white-slight'></div>";
								echo"</div>";
								echo"<h4 class='my-4 font-weight-bold'>SEGI College Penang</h4>";
							echo"</div>";

							echo"<div class='col-lg-4 col-md-6 mb-4'>";
								echo"<div class='view overlay z-depth-1-half'>";
									echo"<img src='images/home/college-tarc.jpg' height=200px width=100% alt=''>";
									echo"<div class='mask rgba-white-slight'></div>";
								echo"</div>";
								echo"<h4 class='my-4 font-weight-bold'>Tunku Abdul Rahman College Kuala Lumpur</h4>";
							echo"</div>";
						echo"</div>";

						echo"<div class='row'>";
							echo"<div class='col-lg-4 col-md-12 mb-4'>";
								echo"<div class='view overlay z-depth-1-half'>";
									echo"<img src='images/home/college-kdu.jpg' height=200px width=100% alt=''>";
									echo"<div class='mask rgba-white-slight'></div>";
								echo"</div>";
								echo"<h4 class='my-4 font-weight-bold'>KDU College Penang</h4>";
							echo"</div>";

							echo"<div class='col-lg-4 col-md-6 mb-4'>";
								echo"<div class='view overlay z-depth-1-half'>";
									echo"<img src='images/home/college-equator.jpg' height=200px width=100% alt=''>";
									echo"<div class='mask rgba-white-slight'></div>";
								echo"</div>";
								echo"<h4 class='my-4 font-weight-bold'>Equator College Penang</h4>";
							echo"</div>";

							echo"<div class='col-lg-4 col-md-6 mb-4'>";
								echo"<div class='view overlay z-depth-1-half'>";
									echo"<img src='images/home/college-medical.jpg' height=200px width=100% alt=''>";
									echo"<div class='mask rgba-white-slight'></div>";
								echo"</div>";
								echo"<h4 class='my-4 font-weight-bold'>Penang Medical College</h4>";
							echo"</div>";
						echo"</div>";						
						echo "<button type='button' class='btn btn-outline-secondary btn-rounded waves-effect'>View More</button>";						
					echo"</section>";

					// echo"<hr class='my-5'>";

					// echo"<section id='gallery'>";
					// 	echo"<h2 class='mb-5 font-weight-bold text-center'>Rating and Review</h2>";
					// 	echo"<div class='row'>";
					// 		echo"<div class='col-md-6 mb-4'>";
					// 			echo"<div id='carousel-example-1z' class='carousel slide carousel-fade carousel-fade' data-ride='carousel'>";
					// 				echo"<ol class='carousel-indicators'>";
					// 					echo"<li data-target='#carousel-example-1z' data-slide-to='0' class='active'></li>";
					// 					echo"<li data-target='#carousel-example-1z' data-slide-to='1'></li>";
					// 					echo"<li data-target='#carousel-example-1z' data-slide-to='2'></li>";
					// 				echo"</ol>";
					// 				echo"<div class='carousel-inner z-depth-1-half' role='listbox'>";
					// 					echo"<div class='carousel-item active'>";
					// 						echo"<img class='d-block w-100' src='https://mdbootstrap.com/img/Photos/Slides/img%20(130).jpg'";
					// 						echo"alt='First slide'>";
					// 					echo"</div>";
					// 					echo"<div class='carousel-item'>";
					// 						echo"<img class='d-block w-100' src='https://mdbootstrap.com/img/Photos/Slides/img%20(129).jpg'";
					// 						echo"alt='Second slide'>";
					// 					echo"</div>";
					// 					echo"<div class='carousel-item'>";
					// 						echo"<img class='d-block w-100' src='https://mdbootstrap.com/img/Photos/Slides/img%20(70).jpg'";
					// 						echo"alt='Third slide'>";
					// 					echo"</div>";
					// 				echo"</div>";
					// 				echo"<a class='carousel-control-prev' href='#carousel-example-1z' role='button' data-slide='prev'>";
					// 					echo"<span class='carousel-control-prev-icon' aria-hidden='true'></span>";
					// 					echo"<span class='sr-only'>Previous</span>";
					// 				echo"</a>";
					// 				echo"<a class='carousel-control-next' href='#carousel-example-1z' role='button' data-slide='next'>";
					// 					echo"<span class='carousel-control-next-icon' aria-hidden='true'></span>";
					// 					echo"<span class='sr-only'>Next</span>";
					// 				echo"</a>";
					// 			echo"</div>";
					// 		echo"</div>";
					// 		echo"<div class='col-md-6'>";
					// 			echo"<a href='' class='teal-text'>";
					// 				echo"<h6 class='pb-1'><i class='fa fa-heart'></i><strong> Lifestyle </strong></h6>";
					// 			echo"</a>";
					// 			echo"<h4 class='mb-3'><strong>This is title of the news</strong></h4>";
					// 			echo"<p>Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id";
					// 			echo"quod maxime";
					// 			echo"placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus et aut";
					// 			echo"officiis";
					// 			echo"debitis aut rerum.</p>";
					// 			echo"<p>Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id";
					// 			echo"quod maxime";
					// 			echo"placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus et aut";
					// 			echo"officiis";
					// 			echo"debitis aut rerum.</p>";
					// 			echo"<p>by <a><strong>Jessica Clark</strong></a>, 26/08/2016</p>";
					// 			echo"<a class='btn btn-primary btn-md'>Read more</a>";
					// 		echo"</div>";
					// 	echo"</div>";
					// echo"</section>";

			// 		echo"<hr class='my-5'>";
			// 		echo"<section id='contact'>";
			// 			echo"<h2 class='mb-5 font-weight-bold text-center'>Contact us</h2>";
			// 			echo"<div class='row'>";
			// 				echo"<div class='col-lg-5 col-md-12'>";
			// 					echo"<form class='p-5 grey-text'>";
			// 						echo"<div class='md-form form-sm'> <i class='fa fa-user prefix'></i>";
			// 							echo"<input type='text' id='form3' class='form-control form-control-sm'>";
			// 							echo"<label for='form3'>Your name</label>";
			// 						echo"</div>";
			// 						echo"<div class='md-form form-sm'> <i class='fa fa-envelope prefix'></i>";
			// 							echo"<input type='text' id='form2' class='form-control form-control-sm'>";
			// 							echo"<label for='form2'>Your email</label>";
			// 						echo"</div>";
			// 						echo"<div class='md-form form-sm'> <i class='fa fa-tag prefix'></i>";
			// 							echo"<input type='text' id='form32' class='form-control form-control-sm'>";
			// 							echo"<label for='form34'>Subject</label>";
			// 						echo"</div>";
			// 							echo"<div class='md-form form-sm'> <i class='fa fa-pencil prefix'></i>";
			// 							echo"<textarea type='text' id='form8' class='md-textarea form-control form-control-sm' rows='4'></textarea>";
			// 							echo"<label for='form8'>Your message</label>";
			// 						echo"</div>";
			// 							echo"<div class='text-center mt-4'>";
			// 							echo"<button class='btn btn-primary'>Send <i class='fa fa-paper-plane-o ml-1'></i></button>";
			// 						echo"</div>";
			// 					echo"</form>";
			// 				echo"</div>";
			// 				echo"<div class='col-lg-7 col-md-12'>";
			// 					echo"<div class='row text-center'>";
			// 						echo"<div class='col-lg-4 col-md-12 mb-3'>";
			// 							echo"<p><i class='fa fa-map fa-1x mr-2 grey-text'></i>New York, NY 10012</p>";
			// 						echo"</div>";
			// 						echo"<div class='col-lg-4 col-md-6 mb-3'>";
			// 							echo"<p><i class='fa fa-building fa-1x mr-2 grey-text'></i>Mon - Fri, 8:00-22:00</p>";
			// 						echo"</div>";
			// 						echo"<div class='col-lg-4 col-md-6 mb-3'>";
			// 							echo"<p><i class='fa fa-phone fa-1x mr-2 grey-text'></i>+ 01 234 567 89</p>";
			// 						echo"</div>";
			// 					echo"</div>";
			// 					echo"<div id='map-container' class='z-depth-1-half map-container mb-5' style='height: 400px'></div>";
			// 				echo"</div>";
			// 			echo"</div>";
			// 		echo"</section>";
				echo"</div>";
			echo"</main>";
			echo "<div class='container-fluid'>";	
			echo "</div>";
			include("footer.php");
		echo "</body>";
	echo "</html>";
?>