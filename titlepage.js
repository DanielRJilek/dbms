class TitlePage {
    constructor(view, container) {
        this.container = container;
        this.view = view;
    }

    createTitle(title_page) {
        const title = document.createElement("div");
        title.textContent = "Airport Management System";
        title.setAttribute("id", "title");
        title_page.appendChild(title);
    }

    createButton(container, name, method) {
        const button = document.createElement("button");
        button.textContent = name;
        button.setAttribute("id", name + "-button");
        button.addEventListener("click", method.bind(this.view));
        container.appendChild(button);
    }

    render() {
        const title_page = document.createElement("div");
        title_page.setAttribute("id", "title-page");
        title_page.classList.add("page");
        this.createTitle(title_page);
        this.createButton(title_page, "Flights", this.view.renderFlightsMenu);
        this.createButton(title_page, "Customers", this.view.renderCustomersMenu);
        this.createButton(title_page, "Staff", this.view.renderStaffMenu);
        this.createButton(title_page, "Aircraft", this.view.renderAircraftMenu);
        this.container.appendChild(title_page);
    }
}

export {TitlePage}