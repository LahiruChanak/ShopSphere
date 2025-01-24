$(document).ready(function () {
    const sidebar = $('.sidebar');
    const sidebarNav = $('#sidebar-nav');
    const sidebarToggle = $('#sidebar-toggle');
    const sidebarToggleIcon = $('#sidebar-toggle-icon');
    const content = $('.content');

    sidebarToggle.click(function () {
        sidebar.toggleClass('collapsed');
        content.toggleClass('collapsed');

        if (sidebar.hasClass('collapsed')) {
            sidebarToggleIcon.find('span:nth-child(1)').css('transform', 'rotate(45deg) translate(5px, 5px)');
            sidebarToggleIcon.find('span:nth-child(2)').css('opacity', '0');
            sidebarToggleIcon.find('span:nth-child(3)').css('transform', 'rotate(-45deg) translate(5px, -5px)');
        } else {
            sidebarToggleIcon.find('span:nth-child(1)').css('transform', 'none');
            sidebarToggleIcon.find('span:nth-child(2)').css('opacity', '1');
            sidebarToggleIcon.find('span:nth-child(3)').css('transform', 'none');
        }
    });
});