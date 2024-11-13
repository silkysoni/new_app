// document.addEventListener('DOMContentLoaded', function() {
//     const types = ['notice', 'alert', 'error'];
  
//     types.forEach(function(type) {
//       const alertElement = document.getElementById(`alert-${type}`);
//       console.log("alertElement ",alertElement);
//       if (alertElement) {
//         setTimeout(function() {
//           alertElement.style.opacity = '0'; // Fade out
//           setTimeout(function() {
//             alertElement.style.display = 'none'; // Remove from view
//           }, 600); // Match with CSS transition time if needed
//         }, 4000); // Wait for 4 seconds
//       }
//     });
//   });
  
//   document.addEventListener('turbo:load', function() {
//     const alerts = document.querySelectorAll('.alert-danger');
//     console.log("alerts ",alerts);
  
//     if (alerts.length > 0) {
//       alerts.forEach(alert => {
//         setTimeout(() => {
//           alert.style.opacity = '0'; // Fade out
//           setTimeout(() => {
//             alert.style.display = 'none'; // Remove from view
//           }, 600); // Match with CSS transition time
//         }, 4000); // Wait for 4 seconds
//       });
//     }
//   });
  
  